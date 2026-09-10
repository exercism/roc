# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/piecing-it-together/canonical-data.json
# File last updated on 2026-09-01

import JigsawData

# 1000 pieces puzzle with 1.6 aspect ratio
expect {
	result = JigsawData.create({ pieces: 1000, aspect_ratio: 1.6 })
	result == Ok({ pieces: 1000, border: 126, inside: 874, rows: 25, columns: 40, aspect_ratio: 1.6, format: Landscape })
}

# square puzzle with 32 rows
expect {
	result = JigsawData.create({ rows: 32, format: Square })
	result == Ok({ pieces: 1024, border: 124, inside: 900, rows: 32, columns: 32, aspect_ratio: 1.0, format: Square })
}

# 400 pieces square puzzle with only inside pieces and aspect ratio
expect {
	result = JigsawData.create({ inside: 324, aspect_ratio: 1.0 })
	result == Ok({ pieces: 400, border: 76, inside: 324, rows: 20, columns: 20, aspect_ratio: 1.0, format: Square })
}

# 1500 pieces landscape puzzle with 30 rows and 1.6 aspect ratio
expect {
	result = JigsawData.create({ rows: 30, aspect_ratio: 1.6666666666666667 })
	result == Ok({ pieces: 1500, border: 156, inside: 1344, rows: 30, columns: 50, aspect_ratio: 1.6666666666666667, format: Landscape })
}

# 300 pieces portrait puzzle with 70 border pieces
expect {
	result = JigsawData.create({ pieces: 300, border: 70, format: Portrait })
	result == Ok({ pieces: 300, border: 70, inside: 230, rows: 25, columns: 12, aspect_ratio: 0.48, format: Portrait })
}

# puzzle with insufficient data
expect {
	result = JigsawData.create({ pieces: 1500, format: Landscape })
	result.is_err()
}

# puzzle with contradictory data
expect {
	result = JigsawData.create({ rows: 100, columns: 1000, format: Square })
	result.is_err()
}
