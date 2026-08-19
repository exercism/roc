# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/grade-school/canonical-data.json
# File last updated on 2026-08-18

import GradeSchool exposing [add, grade, roster]

# Roster is empty when no student is added
expect {
	grade_school = GradeSchool.empty
	result = grade_school.roster()
	result == []
}

# Add a student
expect {
	new_school = GradeSchool.empty
	{ results, updated_school: _ } = new_school.add([
		{ name: "Aimee", grade: 2 },
	])
	results == [
		Accepted,
	]
}

# Student is added to the roster
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Aimee", grade: 2 },
	])
	result = grade_school.roster()
	result == ["Aimee"]
}

# Adding multiple students in the same grade in the roster
expect {
	new_school = GradeSchool.empty
	{ results, updated_school: _ } = new_school.add([
		{ name: "Blair", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "Paul", grade: 2 },
	])
	results == [
		Accepted,
		Accepted,
		Accepted,
	]
}

# Multiple students in the same grade are added to the roster
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Blair", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "Paul", grade: 2 },
	])
	result = grade_school.roster()
	result == ["Blair", "James", "Paul"]
}

# Cannot add student to same grade in the roster more than once
expect {
	new_school = GradeSchool.empty
	{ results, updated_school: _ } = new_school.add([
		{ name: "Blair", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "Paul", grade: 2 },
	])
	results == [
		Accepted,
		Accepted,
		Rejected,
		Accepted,
	]
}

# Student not added to same grade in the roster more than once
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Blair", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "Paul", grade: 2 },
	])
	result = grade_school.roster()
	result == ["Blair", "James", "Paul"]
}

# Adding students in multiple grades
expect {
	new_school = GradeSchool.empty
	{ results, updated_school: _ } = new_school.add([
		{ name: "Chelsea", grade: 3 },
		{ name: "Logan", grade: 7 },
	])
	results == [
		Accepted,
		Accepted,
	]
}

# Students in multiple grades are added to the roster
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Chelsea", grade: 3 },
		{ name: "Logan", grade: 7 },
	])
	result = grade_school.roster()
	result == ["Chelsea", "Logan"]
}

# Cannot add same student to multiple grades in the roster
expect {
	new_school = GradeSchool.empty
	{ results, updated_school: _ } = new_school.add([
		{ name: "Blair", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "James", grade: 3 },
		{ name: "Paul", grade: 3 },
	])
	results == [
		Accepted,
		Accepted,
		Rejected,
		Accepted,
	]
}

# Student not added to multiple grades in the roster
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Blair", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "James", grade: 3 },
		{ name: "Paul", grade: 3 },
	])
	result = grade_school.roster()
	result == ["Blair", "James", "Paul"]
}

# Students are sorted by grades in the roster
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Jim", grade: 3 },
		{ name: "Peter", grade: 2 },
		{ name: "Anna", grade: 1 },
	])
	result = grade_school.roster()
	result == ["Anna", "Peter", "Jim"]
}

# Students are sorted by name in the roster
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Peter", grade: 2 },
		{ name: "Zoe", grade: 2 },
		{ name: "Alex", grade: 2 },
	])
	result = grade_school.roster()
	result == ["Alex", "Peter", "Zoe"]
}

# Students are sorted by grades and then by name in the roster
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Peter", grade: 2 },
		{ name: "Anna", grade: 1 },
		{ name: "Barb", grade: 1 },
		{ name: "Zoe", grade: 2 },
		{ name: "Alex", grade: 2 },
		{ name: "Jim", grade: 3 },
		{ name: "Charlie", grade: 1 },
	])
	result = grade_school.roster()
	result == ["Anna", "Barb", "Charlie", "Alex", "Peter", "Zoe", "Jim"]
}

# Grade is empty if no students in the roster
expect {
	grade_school = GradeSchool.empty
	result = grade_school.grade(1)
	result == []
}

# Grade is empty if no students in that grade
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Peter", grade: 2 },
		{ name: "Zoe", grade: 2 },
		{ name: "Alex", grade: 2 },
		{ name: "Jim", grade: 3 },
	])
	result = grade_school.grade(1)
	result == []
}

# Student not added to same grade more than once
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Blair", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "Paul", grade: 2 },
	])
	result = grade_school.grade(2)
	result == ["Blair", "James", "Paul"]
}

# Student not added to multiple grades
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Blair", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "James", grade: 3 },
		{ name: "Paul", grade: 3 },
	])
	result = grade_school.grade(2)
	result == ["Blair", "James"]
}

# Student not added to other grade for multiple grades
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Blair", grade: 2 },
		{ name: "James", grade: 2 },
		{ name: "James", grade: 3 },
		{ name: "Paul", grade: 3 },
	])
	result = grade_school.grade(3)
	result == ["Paul"]
}

# Students are sorted by name in a grade
expect {
	new_school = GradeSchool.empty
	{ results: _, updated_school: grade_school } = new_school.add([
		{ name: "Franklin", grade: 5 },
		{ name: "Bradley", grade: 5 },
		{ name: "Jeff", grade: 1 },
	])
	result = grade_school.grade(5)
	result == ["Bradley", "Franklin"]
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
