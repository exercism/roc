FamilyTree := Dict(Str, List(Str)).{
    degree_of_separation : FamilyTree, Str, Str -> Try(U64, _)
    degree_of_separation = |FamilyTree.(family_tree), person_a, person_b| {
        crash "Please implement the 'degree_of_separation' function"
    }
}
