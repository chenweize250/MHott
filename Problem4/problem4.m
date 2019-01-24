% Starting point for Jan. 17
load('smallperiodictable')

%Q1
%density(density>1)
%density_l = density > 1;
%density_l(density_l == 1)
%names(density_l == 1)
%dense_names = names(i) 

d = numel(density(density>1));
str1 = "There are %d elements denser than water in their natural form. These elements are";
sprintf(str1, d)

density_l = density > 1;
names(density_l == 1)

%Q2
i = numel(isotopes(isotopes>100));
str2 = "There are %d elements with over 100 isotopes. These elements are";
sprintf(str2, i)

isotopes_l = isotopes > 100;
names(isotopes_l)

%Q3
j = numel(discyear(discyear < 1900));
str3 = "%d elements were discovered before 1900. These elements are";
sprintf(str3, j)

discyear_l = discyear < 1900;
names(discyear_l)

%Q4
plot(atomicweight, density)
axis([0, 252, 0, 25])
title("Density vs Atomic Weight")
xlabel("Atomic Weight")
ylabel("Density")