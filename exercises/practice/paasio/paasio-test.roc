# These tests are maintained by the Roc track; paasio has no canonical test data.
app [main!] {
	pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.24.0/AEjfyaMFFbh8FJrkkHJy68riVNPr3Qp6c6PawWQjBwMH.tar.zst",
}

import pf.Env
import pf.File
import pf.Path
import pf.Stderr
import Paasio

TestError : [Denied(Str), Unavailable(U64), UnscriptedOperation]

Request : [Read(U64), Write(List(U8))]

Response : [ReadResult(Try(List(U8), TestError)), WriteResult(Try(U64, TestError))]

TestState : {
	reads : List(Try(List(U8), TestError)),
	writes : List(Try(U64, TestError)),
	requests : List(Request),
}

Case : {
	description : Str,
	reads : List(Try(List(U8), TestError)),
	writes : List(Try(U64, TestError)),
	requests : List(Request),
	responses : List(Response),
	stats : Paasio.Stats,
}

read_mock! : TestState, U64 => Paasio.Outcome(TestState, List(U8), TestError)
read_mock! = |state, max_bytes| {
	{ result, remaining } = match state.reads {
		[first, .. as rest] => { result: first, remaining: rest }
		[] => { result: Err(UnscriptedOperation), remaining: [] }
	}
	{ state: { ..state, reads: remaining, requests: state.requests.append(Read(max_bytes)) }, result }
}

write_mock! : TestState, List(U8) => Paasio.Outcome(TestState, U64, TestError)
write_mock! = |state, bytes| {
	{ result, remaining } = match state.writes {
		[first, .. as rest] => { result: first, remaining: rest }
		[] => { result: Err(UnscriptedOperation), remaining: [] }
	}
	{ state: { ..state, writes: remaining, requests: state.requests.append(Write(bytes)) }, result }
}

zero_stats : Paasio.Stats
zero_stats = { read_bytes: 0, read_operations: 0, write_bytes: 0, write_operations: 0 }

run_case! : Case => Try({}, Str)
run_case! = |case| {
	initial_state = { reads: case.reads, writes: case.writes, requests: [] }
	var $io = Paasio.create({ state: initial_state, read!: read_mock!, write!: write_mock! })
	if $io.stats() != zero_stats or $io.get_state() != initial_state {
		return Err("${case.description}: creation must preserve the backend and start with zero counters")
	}
	var $responses = []
	for request in case.requests {
		match request {
			Read(max_bytes) => {
				{ io, result } = $io.read!(max_bytes)
				$io = io
				$responses = $responses.append(ReadResult(result))
			}
			Write(bytes) => {
				{ io, result } = $io.write!(bytes)
				$io = io
				$responses = $responses.append(WriteResult(result))
			}
		}
	}
	actual_state = $io.get_state()
	expected_state = { reads: [], writes: [], requests: case.requests }
	if actual_state != expected_state {
		return Err("${case.description}: backend state mismatch: ${Str.inspect({ expected: expected_state, actual: actual_state })}")
	}
	if $responses != case.responses {
		return Err("${case.description}: result mismatch: ${Str.inspect({ expected: case.responses, actual: $responses })}")
	}
	if $io.stats() != case.stats {
		return Err("${case.description}: statistics mismatch: ${Str.inspect({ expected: case.stats, actual: $io.stats() })}")
	}
	Ok({})
}

cases : List(Case)
cases = [
	{
		description: "read returns bytes and counts their length",
		reads: [Ok([1, 2, 3])],
		writes: [],
		requests: [Read(10)],
		responses: [ReadResult(Ok([1, 2, 3]))],
		stats: { read_bytes: 3, read_operations: 1, write_bytes: 0, write_operations: 0 },
	},
	{
		description: "short reads are not retried",
		reads: [Ok([1]), Ok([2, 3])],
		writes: [],
		requests: [Read(4), Read(4)],
		responses: [ReadResult(Ok([1])), ReadResult(Ok([2, 3]))],
		stats: { read_bytes: 3, read_operations: 2, write_bytes: 0, write_operations: 0 },
	},
	{
		description: "end of file still counts as a read",
		reads: [Ok([])],
		writes: [],
		requests: [Read(8)],
		responses: [ReadResult(Ok([]))],
		stats: { read_bytes: 0, read_operations: 1, write_bytes: 0, write_operations: 0 },
	},
	{
		description: "zero-byte read requests are delegated",
		reads: [Ok([])],
		writes: [],
		requests: [Read(0)],
		responses: [ReadResult(Ok([]))],
		stats: { read_bytes: 0, read_operations: 1, write_bytes: 0, write_operations: 0 },
	},
	{
		description: "read errors preserve their payload and updated state",
		reads: [Err(Denied("read forbidden"))],
		writes: [],
		requests: [Read(5)],
		responses: [ReadResult(Err(Denied("read forbidden")))],
		stats: { read_bytes: 0, read_operations: 1, write_bytes: 0, write_operations: 0 },
	},
	{
		description: "reads continue after a failure",
		reads: [Ok([1, 2]), Err(Unavailable(42)), Ok([3, 4, 5])],
		writes: [],
		requests: [Read(3), Read(8), Read(6)],
		responses: [ReadResult(Ok([1, 2])), ReadResult(Err(Unavailable(42))), ReadResult(Ok([3, 4, 5]))],
		stats: { read_bytes: 5, read_operations: 3, write_bytes: 0, write_operations: 0 },
	},
	{
		description: "writes forward all bytes unchanged",
		reads: [],
		writes: [Ok(4)],
		requests: [Write([0, 255, 128, 10])],
		responses: [WriteResult(Ok(4))],
		stats: { read_bytes: 0, read_operations: 0, write_bytes: 4, write_operations: 1 },
	},
	{
		description: "short writes count the reported bytes and do not retry",
		reads: [],
		writes: [Ok(2)],
		requests: [Write([1, 2, 3, 4, 5])],
		responses: [WriteResult(Ok(2))],
		stats: { read_bytes: 0, read_operations: 0, write_bytes: 2, write_operations: 1 },
	},
	{
		description: "a write can succeed without transferring bytes",
		reads: [],
		writes: [Ok(0)],
		requests: [Write([1, 2])],
		responses: [WriteResult(Ok(0))],
		stats: { read_bytes: 0, read_operations: 0, write_bytes: 0, write_operations: 1 },
	},
	{
		description: "empty writes are delegated",
		reads: [],
		writes: [Ok(0)],
		requests: [Write([])],
		responses: [WriteResult(Ok(0))],
		stats: { read_bytes: 0, read_operations: 0, write_bytes: 0, write_operations: 1 },
	},
	{
		description: "write errors preserve their payload and updated state",
		reads: [],
		writes: [Err(Denied("write forbidden"))],
		requests: [Write([1, 2, 3])],
		responses: [WriteResult(Err(Denied("write forbidden")))],
		stats: { read_bytes: 0, read_operations: 0, write_bytes: 0, write_operations: 1 },
	},
	{
		description: "writes continue after a failure",
		reads: [],
		writes: [Ok(2), Err(Unavailable(9)), Ok(1)],
		requests: [Write([1, 2]), Write([3, 4]), Write([5, 6])],
		responses: [WriteResult(Ok(2)), WriteResult(Err(Unavailable(9))), WriteResult(Ok(1))],
		stats: { read_bytes: 0, read_operations: 0, write_bytes: 3, write_operations: 3 },
	},
	{
		description: "read and write counters are independent",
		reads: [Ok([10, 20]), Err(Denied("closed"))],
		writes: [Ok(1), Ok(3)],
		requests: [Read(4), Write([30, 40]), Read(8), Write([50, 60, 70])],
		responses: [ReadResult(Ok([10, 20])), WriteResult(Ok(1)), ReadResult(Err(Denied("closed"))), WriteResult(Ok(3))],
		stats: { read_bytes: 2, read_operations: 2, write_bytes: 4, write_operations: 2 },
	},
	{
		description: "Unicode transfers count bytes rather than characters",
		reads: [Ok("é🙂".to_utf8())],
		writes: [Ok(6)],
		requests: [Read(10), Write("é🙂".to_utf8())],
		responses: [ReadResult(Ok("é🙂".to_utf8())), WriteResult(Ok(6))],
		stats: { read_bytes: 6, read_operations: 1, write_bytes: 6, write_operations: 1 },
	},
]

# This backend has a different state type and error type, and captures a byte in its callbacks.
counter_backend : U8 -> Paasio.Backend(U64, [Offline(U64)])
counter_backend = |byte| {
	{
		state: 0,
		read!: |state, max_bytes| {
			{ state: state + 1, result: Ok(if max_bytes == 0 [] else [byte]) }
		},
		write!: |state, bytes| {
			result = if bytes.contains(byte) Ok(bytes.len()) else Err(Offline(state))
			{ state: state + 10, result }
		},
	}
}

test_independent_wrappers! : () => Try({}, Str)
test_independent_wrappers! = || {
	first = Paasio.create(counter_backend(7))
	second = Paasio.create(counter_backend(9))
	a = first.read!(10)
	b = a.io.write!([7, 7])
	c = second.read!(1)
	d = c.io.write!([1])
	if a.result != Ok([7]) or b.result != Ok(2) or c.result != Ok([9]) or d.result != Err(Offline(1)) {
		return Err("independent wrappers: callbacks, captured values, or generic errors were not preserved")
	}
	if b.io.get_state() != 11 or d.io.get_state() != 11 {
		return Err("independent wrappers: generic backend state was not preserved")
	}
	if b.io.stats() != { read_bytes: 1, read_operations: 1, write_bytes: 2, write_operations: 1 } or
		d.io.stats() != { read_bytes: 1, read_operations: 1, write_bytes: 0, write_operations: 1 } {
		return Err("independent wrappers: statistics leaked between wrappers or directions")
	}
	Ok({})
}

# This backend replaces the file on writes and reads it incrementally.
FileState : { path : Path, offset : U64 }

read_file_chunk! : FileState, U64 => Try(List(U8), Str)
read_file_chunk! = |state, max_bytes| {
	reader = File.open_reader!(state.path) ? |err| Str.inspect(err)
	_ = reader.seek!(Start(state.offset)) ? |err| Str.inspect(err)
	reader.read_up_to!(max_bytes).map_err(|err| Str.inspect(err))
}

file_backend : Path -> Paasio.Backend(FileState, Str)
file_backend = |path| {
	{
		state: { path, offset: 0 },
		read!: |state, max_bytes| {
			result = read_file_chunk!(state, max_bytes)
			offset = match result {
				Ok(bytes) => state.offset + bytes.len()
				Err(_) => state.offset
			}
			{ state: { ..state, offset }, result }
		},
		write!: |state, bytes| {
			result = state.path.write_bytes!(bytes).map_ok(|_| bytes.len()).map_err(|err| Str.inspect(err))
			{ state: { ..state, offset: 0 }, result }
		},
	}
}

test_file_roundtrip! : Path => Try({}, Str)
test_file_roundtrip! = |directory| {
	path = directory.join("paasio.bin")
	bytes = [0, 255, 128, 10].concat("é🙂".to_utf8())
	written = Paasio.create(file_backend(path)).write!(bytes)
	if written.result != Ok(bytes.len()) {
		return Err("file write: ${Str.inspect(written.result)}")
	}
	on_disk = path.read_bytes!() ? |err| Str.inspect(err)
	if on_disk != bytes {
		return Err("file write: contents on disk differ from the supplied bytes")
	}
	var $io = written.io
	var $received = []
	var $reads = 0.U64
	# Allow short reads, but bound the loop so a broken wrapper cannot hang the test.
	while $reads <= bytes.len() {
		{ io, result } = $io.read!(3)
		$io = io
		$reads = $reads + 1
		chunk = result?
		if chunk.len() > 3 {
			return Err("file read: returned more bytes than requested")
		}
		if chunk.is_empty() {
			if $received != bytes {
				return Err("file read: the round trip changed the contents")
			}
			expected = { read_bytes: bytes.len(), read_operations: $reads, write_bytes: bytes.len(), write_operations: 1 }
			if $io.stats() != expected {
				return Err("file round trip: statistics mismatch: ${Str.inspect({ expected, actual: $io.stats() })}")
			}
			return Ok({})
		}
		$received = $received.concat(chunk)
	}
	Err("file read: did not reach EOF")
}

test_real_file! : () => Try({}, Str)
test_real_file! = || {
	Env.with_temp_dir!(test_file_roundtrip!).map_err(|err| "real file: ${Str.inspect(err)}")
}

main! = |_args| {
	var $results = []
	for case in cases {
		$results = $results.append(run_case!(case))
	}
	$results = $results.append(test_independent_wrappers!())
	$results = $results.append(test_real_file!())
	failures = $results.keep_errs(|message| message)
	for failure in failures {
		_ = Stderr.line!(failure)
	}
	passed = $results.len() - failures.len()
	_ = Stderr.line!("${passed.to_str()} passed, ${failures.len().to_str()} failed")
	if failures.is_empty() Ok({}) else Err(Exit(1))
}
