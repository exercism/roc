GradeSchool :: {
	# TODO: change this opaque type however you need
	todo1 : U64,
	todo2 : U64,
	todo3 : U64,
	# etc.
}.{
	Student : { name : Str, grade : U8 }

	empty : GradeSchool
	empty = {
		crash "Please implement the 'empty' definition"
	}

	add : GradeSchool, List(Student) -> { results : List([Accepted, Rejected]), updated_school : GradeSchool }
	add = |grade_school, new_student_grade_pairs| {
		crash "Please implement the 'add' function"
	}

	roster : GradeSchool -> List(Str)
	roster = |grade_school| {
		crash "Please implement the 'roster' function"
	}

	grade : GradeSchool, U8 -> List(Str)
	grade = |grade_school, grade| {
		crash "Please implement the 'grade' function"
	}
}
