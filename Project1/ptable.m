
function [a] = ptable(varargin)
      
       c = varargin(1)
       d = varargin(2)
       e = cell2mat(varargin(1))
       f = cell2mat(varargin(2))
csvfile = 'periodictabledata.csv';
table = readtable(csvfile);
a = length(varargin);

%constants
m_p = 938.272; %MeV
m_n = 939.566; %MeV
a_v = 15.8;
a_s = 18.3;
a_c = 0.714;
a_A = 23.2;
a_p = 12;
amu2MeV = 931.4940954;

%delta function
delta = @(a, z) ((mod(a, 2)-1)).^2.*(-1).^z;
        
%Semi-Empirical Mass Formula
EB = @(a, z) a_v.*a-a_s.*a.^(2/3)-a_c.*z.*(z-1)./a.^(1/3)-a_A.*(a-2.*z).^2./a+a_p.*delta(a,z)./a.^(1/2);
m_sef = @(a, z) z*m_p+(a-z)*m_n-EB(a, z); %c=1

switch a
    case 0
        A = round(table2array(table(:, 4)))';%total number of nucleons
        Z = table2array(table(:, 1))';
        
        %mass calculated from atomic weight
        aw = table2array(table(:, 4))';
        m_aw = @(x) amu2MeV*x;
        
        %plot of calculated masses
        subplot(2,1,1);
        yyaxis left;
        plot(Z, m_sef(A, Z))
        title("Mass (MeV) vs Atomic Number")
        xlabel("Atomic Number")
        ylabel("Mass From Semi-Empirical Formula") 
        yyaxis right;
        plot(Z, m_aw(aw))
        ylabel("Mass From Atomic Weight")
        
        subplot(2,1,2); 
        plot(Z, EB(A, Z)./A)
        title("Binding Energy Per Nucleon (MeV)")
        xlabel("Atomic Number")
        ylabel("Binding Energy")
        

        
        
    case 1
        Z = varargin{1}; %atomic number
        if Z > 112
            error("Input atomic number less than 113")
        else
           % A = round(table( , 4)
        end
        
    case 2
        try %continues if both are numbers
            Z = cell2mat(varargin(1));
            A = cell2mat(varargin(2));
            assert(double(Z));
            assert(double(A));
        catch %if one is character
            
        
        end
        
        %if isa(c, 'numeric') && isa(d, 'numeric')

            fprintf("1")
        %Z = varargin{1}; %atomic number
        %A = varargin{2}; %number of nucleons
        
        %m = m_sef(A, Z)
        %benergy = EB(A, Z)
        
        %if Z > 83 %unstable
            
       % else
            
                
            
        
        
        
        
        %fprintf("2\n")
        %tf = isa(
        %make another switch/if to determine is one of the variables is
        %char
        %end
end
%a = nargout
%varargout = a
end


