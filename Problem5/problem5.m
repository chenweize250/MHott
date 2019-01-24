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
ax1 = subplot(2,1,1);
ax2 = subplot(2,1,2);

year = X(:,1);
plot(ax1, year, industrylandsum)
title(ax1, 'Cumulative Carbon Emissions vs Year')
xlabel(ax1, 'Year')
ylabel(ax1, 'Cumulative Carbon Emissions') %find units

temp = T(1:168, 2);
plot(ax2, industrylandsum, temp);
title(ax2, 'Average Global Temperature vs Cumulative Carbon Emissions')
xlabel(ax2, 'Cumulative Carbon Emissions') %find units
ylabel(ax2, 'Average Global Temperature') %find units
%change axis limit

%save data to .mat file