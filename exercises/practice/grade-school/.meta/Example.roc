GradeSchool :: {
	students : List(GradeSchool.Student),
}.{
	Student : { name : Str, grade : U8 }

	empty : GradeSchool
	empty = {
		{ students: [] }
	}

	add : GradeSchool, List(Student) -> { results : List([Accepted, Rejected]), updated_school : GradeSchool }
	add = |grade_school, new_student_grade_pairs| {
		initial_state = { results: [], updated_school: grade_school }
		new_student_grade_pairs.fold(initial_state, add_student)
	}

	roster : GradeSchool -> List(Str)
	roster = |grade_school| {
		grade_school.students
			.sort_with(compare_students)
			.map(|student| student.name)
	}

	grade : GradeSchool, U8 -> List(Str)
	grade = |grade_school, grade| {
		grade_school.students
			.keep_if(|student| student.grade == grade)
			.map(|student| student.name)
			.sort_with(compare_strings)
	}
}

add_student : { results : List([Accepted, Rejected]), updated_school : GradeSchool }, Student -> { results : List([Accepted, Rejected]), updated_school : GradeSchool }
add_student = |state, student| {
	if state.updated_school.roster().contains(student.name) {
		{ updated_school: state.updated_school, results: state.results.append(Rejected) }
	} else {
		students = state.updated_school.students.append(student)
		{ updated_school: GradeSchool.{ students }, results: state.results.append(Accepted) }
	}
}

compare_strings : Str, Str -> [LT, EQ, GT]
compare_strings = |string1, string2| {
	b1 = string1.to_utf8()
	b2 = string2.to_utf8()
	result =
		b1.map2(b2, |c1, c2| c1.compare(c2))
			.fold_try(
				Ok(EQ),
				|_state, cmp| {
					match cmp {
						EQ => Ok(EQ)
						res => Err(res)
					}
				},
			)
	match result {
		Ok(_cmp) => b1.len().compare(b2.len())
		Err(res) => res
	}
}

compare_students = |student1, student2| {
	compare_grades = student1.grade.compare(student2.grade)
	match compare_grades {
		LT | GT => compare_grades
		EQ => compare_strings(student1.name, student2.name)
	}
}
