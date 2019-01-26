%import data
xlsfile = '/Users/meganhott/Documents/GitHub/MHott/Problem5/GlobalCarbonBudget2018.xlsx';
X = xlsread(xlsfile, 'Historical Budget','A116:G283');

txtfile = '/Users/meganhott/Documents/GitHub/MHott/Problem5/GlobalTempbyYear.txt';
T = importdata(txtfile, ' ');

%cumulative sum
industry = X(:,2);
industrysum = cumsum(industry);
land = X(:, 3);
landsum = cumsum(land);
industrylandsum = (industrysum + landsum);

%plots
year = X(:,1);
temp = T(1:168, 2);

subplot(2,1,1);
yyaxis left;
plot(year, industrylandsum)
title('Cumulative Emissions and Average Temperature vs Year')
xlabel('Year')
ylabel('Cumulative Carbon Emissions') %find units
yyaxis right;
plot(year, temp)
ylabel('Average Global Temperature')

subplot(2,1,2);
plot(industrylandsum, temp);
title('Average Global Temperature vs Cumulative Carbon Emissions')
xlabel('Cumulative Carbon Emissions') %find units
ylabel('Average Global Temperature') %find units
%change axis limit

%save data to .mat file
save('problem5data.mat', 'year', 'temp', 'industrylandsum') %check line