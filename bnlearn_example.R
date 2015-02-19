# http://www.bnlearn.com/examples/dag/

library(bnlearn)
e = empty.graph(LETTERS[1:6])
class(e)
e
empty.graph(LETTERS[1:6], num = 2)
arc.set = matrix(c("A", "C", "B", "F", "C", "F"),
           ncol = 2, byrow = TRUE,
           dimnames = list(NULL, c("from", "to")))
arc.set
arcs(e) = arc.set
e
bogus = matrix(c("X", "Y", "W", "Z"),
         ncol = 2, byrow = TRUE,
         dimnames = list(NULL, c("from", "to")))
bogus
arcs(e) = bogus

cycle = matrix(c("A", "C", "C", "B", "B", "A"),
         ncol = 2, byrow = TRUE,
         dimnames = list(NULL, c("from", "to")))
cycle


arcs(e) = cycle

arcs(e, ignore.cycles = TRUE) = cycle
acyclic(e)

loops = matrix(c("A", "A", "B", "B", "C", "D"),
           ncol = 2, byrow = TRUE,
           dimnames = list(NULL, c("from", "to")))
loops
arcs(e) = loops


edges = matrix(c("A", "B", "B", "A", "C", "D"),
         ncol = 2, byrow = TRUE,
         dimnames = list(NULL, c("from", "to")))
edges
arcs(e) = edges


adj = matrix(0L, ncol = 6, nrow = 6,
         dimnames = list(LETTERS[1:6], LETTERS[1:6]))
adj["A", "C"] = 1L
adj["B", "F"] = 1L
adj["C", "F"] = 1L
adj["D", "E"] = 1L
adj["A", "E"] = 1L
adj
amat(e) = adj # Assign or extract various quantities of interest from an object of class ‘bn’ of ‘bn.fit’.
e

model2network("[A][C][B|A][D|C][F|A:B:C][E|F]")  # each node is enclosed in square brackets; and its parents are listed after a pipe and separated by colons, also within the same set of square brackets.


modelstring(e) = "[A][C][B|A][D|C][F|A:B:C][E|F]"
e

random.graph(LETTERS[1:6], prob = 0.1)

random.graph(LETTERS[1:6], num = 2, method = "ic-dag")

random.graph(LETTERS[1:6], method = "melancon")



data(learning.test)
learning.test
data(gaussian.test)
learn.net = empty.graph(names(learning.test))
modelstring(learn.net) = "[A][C][F][B|A][D|A:C][E|B:F]"
learn.net

gauss.net = empty.graph(names(gaussian.test))
modelstring(gauss.net) = "[A][B][E][G][C|A:B][D|B][F|A:D:E:G]"
gauss.net

score(learn.net, learning.test)
score(gauss.net, gaussian.test)

score(learn.net, learning.test, type = "bic")
score(learn.net, learning.test, type = "aic")
score(learn.net, learning.test, type = "bde")
score(learn.net, learning.test, type = "bde", iss = 1)
score(gauss.net, gaussian.test, type = "bge", iss = 3)

score(learn.net, learning.test[, -1])
score(learn.net, learning.test[, sample(1:6)])

renamed.test = learning.test
names(renamed.test) = LETTERS[11:16]
score(learn.net, renamed.test)
score(learn.net, learning.test, type = "???")

eq.net = set.arc(gauss.net, "D", "B")
score(gauss.net, gaussian.test, type = "bic-g")


score(eq.net, gaussian.test, type = "bic-g")
all.equal(cpdag(gauss.net), cpdag(eq.net))

noneq1.net = set.arc(gauss.net, from = "B", to = "C")
score(noneq1.net, gaussian.test, type = "bic-g")

noneq2.net = set.arc(gauss.net, from = "C", to = "B")
score(noneq2.net, gaussian.test, type = "bic-g")

choose.direction(gauss.net, data = gaussian.test, c("B", "D"), criterion = "bic-g", debug= TRUE)

choose.direction(gauss.net, data = gaussian.test, c("B", "C"), criterion = "bic-g", debug = TRUE)