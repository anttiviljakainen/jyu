setwd("C:/Downloads/JYU/TILS646/Demo1")

rm(list=ls(all=TRUE))

### Tehtävä 1

diabetes.train = read.table("diabetes_train.txt")
diabetes.test = read.table("diabetes_test.txt")
diabetes.cols = !names(diabetes.train) %in% "class"

teht1 = function(method) {
	distmat = as.matrix(dist(rbind(diabetes.train[, diabetes.cols], diabetes.test[, diabetes.cols]), method = method))
	distmat = distmat[nrow(diabetes.train) + 1 : nrow(diabetes.test), 1:nrow(diabetes.train)]

	predclass = diabetes.train$class[apply(distmat, 1, which.min)]
	predcorrect = predclass == diabetes.test$class
	print(paste(method, "luokitteluvirhe:", 1 - (sum(predcorrect) / length(predcorrect))))
}

teht1("euclidean")
teht1("manhattan")

### Tehtävä 2

library(class)

diabetes.train = read.table("diabetes_train.txt")
diabetes.test = read.table("diabetes_test.txt")
diabetes.cols = !names(diabetes.train) %in% "class"

teht2 = function(k, std = FALSE) {
	trainData = diabetes.train[, diabetes.cols]
	testData = diabetes.test[, diabetes.cols]

	if (std) {
		trainData = scale(trainData)
		testData = scale(testData)
	}

	predclass = knn(trainData, testData, diabetes.train$class, k = k)
	predcorrect = diabetes.test$class == predclass
	print(paste("k = ", k, "luokitteluvirhe:", 1 - (sum(predcorrect) / length(predcorrect))))
}

### 2b
for (k in 1 : 10) teht2(k)

### 2c
for (k in 1 : 10) teht2(k, TRUE)

### Tehtävä 4

t4data = read.table("contact_lenses.txt")

### Tehtävä 4a: Tear_prod_rate ja Astigmatism

t4data[order(t4data$Contact_lenses),]

t4datas1 = subset(t4data, Tear_prod_rate == "normal")
t4datas1[order(t4datas1$Contact_lenses),]

t4datas1 = subset(t4data, Tear_prod_rate != "normal")
t4datas1[order(t4datas1$Contact_lenses),]

t4datas1 = subset(t4data, Astigmatism == "yes")
t4datas1[order(t4datas1$Contact_lenses),]

t4datas1 = subset(t4data, Astigmatism == "no")
t4datas1[order(t4datas1$Contact_lenses),]

### 4b

### 4c

### 4d

library("RWeka")

lenses = read.table("Contact_lenses.txt")
table(lenses$Contact_lenses)
nrow(lenses)
names(lenses)

table(lenses$Contact_lenses, lenses$Astigmatism)

a = table(lenses$Contact_lenses) / nrow(lenses)
print(paste("H(Y) =", sum(a * log(a))))


### Tehtävä 5

data(iris)

hist(iris$Petal.Length)

boxplot(Petal.Length ~ Species, iris)

entr = function(fac) {
	p_class = table(fac) / length(fac)
	return(-sum(p_class * log(p_class)))
}

ih = function(PL) {
	fac = iris$Petal.Length <= PL

	lower = subset(iris, fac == TRUE)
	higher = subset(iris, fac == FALSE)

	hyxe1 = entr(droplevels(lower$Species))
	hyxe2 = entr(droplevels(higher$Species))
	hyx = nrow(lower) / nrow(iris) * hyxe1 + nrow(higher) / nrow(iris) * hyxe2

	hy = entr(iris$Species)

	return(hy - hyx)
}

ih(2)
ih(5)



### Tehtävä 6

library("MASS")

bugs.train = read.table("bugs_train.txt")
bugs.test = read.table("bugs_test.txt")
bugs.cols = !names(t6train) %in% "Species"

L = lda(Species ~ ., bugs.train)
Q = qda(Species ~ ., bugs.train)

P = predict(L, bugs.test)$class == bugs.test$Species
print(paste("LDA:n luokitteluvirhe:", (1 - sum(P) / nrow(bugs.test))))
P = predict(Q, bugs.test)$class == bugs.test$Species
print(paste("QDA:n luokitteluvirhe:", (1 - sum(P) / nrow(bugs.test))))



### Tehtävä 7

rm(list=ls(all=TRUE))

library("klaR")
library("MASS")

bugs.train = read.table("bugs_train.txt")
bugs.test = read.table("bugs_test.txt")

N = NaiveBayes(Species ~ ., bugs.train)
P = predict(N, bugs.test)$class == bugs.test$Species
print(paste("NB:n luokitteluvirhe:", (1 - sum(P) / nrow(bugs.test))))

## 7b: Aineistosta luokittain estimoituja

# 7c

teht7c = function(prior = NA) {
	if (is.na(prior)) {
		L = lda(Species ~ ., bugs.train)
		Q = qda(Species ~ ., bugs.train)
		N = NaiveBayes(Species ~ ., bugs.train)
	} else {
		L = lda(Species ~ ., bugs.train, prior = prior)
		Q = qda(Species ~ ., bugs.train, prior = prior)
		N = NaiveBayes(Species ~ ., bugs.train, prior = prior)
	}

	P = predict(L, bugs.test)$class == bugs.test$Species
	print(paste("LDA:n luokitteluvirhe:", (1 - sum(P) / nrow(bugs.test))))
	P = predict(Q, bugs.test)$class == bugs.test$Species	
	print(paste("QDA:n luokitteluvirhe:", (1 - sum(P) / nrow(bugs.test))))
	P = predict(N, bugs.test)$class == bugs.test$Species	
	print(paste("NB:n luokitteluvirhe:", (1 - sum(P) / nrow(bugs.test))))
}

nSpecies = length(levels(bugs.train$Species))

# Ei prioria
teht7c()

# Tasapriori
teht7c(rep(1, nSpecies) / nSpecies)

# Luokan frekvenssin mukainen priori
teht7c(as.vector(table(bugs.test$Species) / nrow(bugs.test)))


### Tehtävä 8

rm(list=ls(all=TRUE))

library("klaR")
library("MASS")

bugs.train = read.table("bugs_train.txt")
bugs.test = read.table("bugs_test.txt")
bugs = rbind(bugs.train, bugs.test)
bugs.cols = !names(bugs) %in% "Species"

# 8a

keskiarvo = aggregate(. ~ Species, bugs, mean)
keskiarvo = keskiarvo[,-1]
kovarianssit = as.list(by(bugs[,bugs.cols], bugs$Species, cov))

# 8b

#Simuloidaan normaalijakautuneet piirteet
maarat <- table(bugs$Species)

#16 tulee piirteiden maarasta
mvn.sim <- function(n, mu, sigma) {
	y <- matrix(rep(0, 16 * n), ncol = n)
	c <- t(chol(sigma))
	for(j in 1:n) {
		a = matrix(rnorm(16,0,1),ncol=1)
		v = mu + c%*% matrix(rnorm(16,0,1),ncol=1)
		y[,j] <- t(v)
	}
	t(y)
}

#Tarvitset a)-kohdassa estimoidut keskiarvo (matriisi) ja
#kovarianssit (lista matriiseista)
sim.data <- NULL

for(i in 1:8){
	sim.data <- rbind(sim.data, mvn.sim(maarat[i], keskiarvo[i,], kovarianssit[[i]]))
}

sim.data <- as.data.frame(sim.data)
grouping <- bugs$Species
lajit <- levels(grouping)
Luokat <- NULL
for(i in 1:8){
	Luokat<-c(Luokat,rep(lajit[i],maarat[i]))
}
Luokat <- factor(Luokat)
sim.data <- cbind(Luokat, sim.data)
names(sim.data) <- names(bugs)

## 

n = nrow(sim.data)
sim.data.sample = sample(n, n * 0.8)
sim.data.train = sim.data[sim.data.sample,]
sim.data.test = sim.data[-sim.data.sample,]

Q = qda(Species ~ ., sim.data.train)
P = predict(Q, sim.data.test)$class == sim.data.test$Species	
print(paste("QDA:n luokitteluvirhe:", (1 - sum(P) / nrow(sim.data.test))))

