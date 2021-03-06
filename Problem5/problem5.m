%import data
%{
absolute path
xlsfile = '/Users/meganhott/Documents/GitHub/MHott/Problem5/GlobalCarbonBudget2018.xlsx';
txtfile = '/Users/meganhott/Documents/GitHub/MHott/Problem5/GlobalTempbyYear.txt';
%}
%relative path
xlsfile = 'GlobalCarbonBudget2018.xlsx';
X = xlsread(xlsfile, 'Historical Budget','A116:G283');

txtfile = 'GlobalTempbyYear.txt';
T = importdata(txtfile, ' ');

%cumulative sum
industry = X(:,2);
industrysum = cumsum(industry);
land = X(:, 3);
landsum = cumsum(land);
totalsum = (industrysum + landsum);

%plots
year = X(:,1);
temp = T(1:168, 2);

subplot(2,1,1);
yyaxis left;
plot(year, totalsum)
title('Cumulative Emissions and Average Temperature vs Year')
xlabel('Year')
ylabel('Cumulative Carbon Emissions (10^1^2 kg)')
yyaxis right;
plot(year, temp)
y = ['Average Global Temperature (',char(176), 'C)'];
ylabel(y)

subplot(2,1,2);
plot(totalsum, temp);
title('Average Global Temperature vs Cumulative Carbon Emissions')
xlabel('Cumulative Carbon Emissions (10^1^2 kg)')
ylabel(y)
axis([0, 630, -.6, 1])

%save data to .mat file
save('problem5datama.mat', 'year', 'temp', 'totalsum')