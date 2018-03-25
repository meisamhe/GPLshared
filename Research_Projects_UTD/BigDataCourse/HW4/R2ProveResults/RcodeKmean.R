filePath="C:/Users/MeisamHe/Desktop/Desktop/BackupToRestoreComputerApril15/BigDataSpring2015/HWs/HW4/datasethw4(1)/dataset/Q1_testkmean.txt"
toKmeanCluster = read.table(filePath)
cl <- kmeans(toKmeanCluster, 3)

# original Mean
(V1,V2)=(4.375,5.875)

initial0= c(4.375,5.875)
initial1 = c(4.375,5.875-1)
initial2 = c(4.375-1,5.875)

center=rbind(initial0,initial1,initial2)

cl1=kmeans(toKmeanCluster, centers=center)

cl1$centers

#========================================
# Homework 5 test
#========================================
dataPoitns = matrix(c(2,2,8,5,7,6,1,4,10,5,4,8,5,4,2,9),ncol=2)

initial0= c(2,10)
initial1 = c(5,8)
initial2 = c(1,2)

center=rbind(initial0,initial1,initial2)

cl1=kmeans(dataPoitns, centers=center)

cl1$centers