%Rule to find classmates of a student
classmate(S1, S2) :- student(S1, X), student(S2, X), S1\=S2.
%Rule to count subjects in a branch
countsubjects(Branch, Count) :-
	findall(Subjects,
		(
		    studies(Branch, Subjects)
		),
		AllSubjects), length(AllSubjects, Count).
%Facts given
student(ram, cse).
student(kirat, com).
student(ajay, cse).
student(amit, cmt).
studies(cmt, uc).
studies(cmt, pm).
studies(com, pm).
studies(com, aplc).
studies(com, ads).
studies(cse, aplc).
studies(cse, pm).
studies(cse, algorithms).
studies(cmt, pm).
