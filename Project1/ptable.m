function [varargout] = ptable(varargin)
       
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
        set(gcf, 'position', [0, 0, 1000, 1000])
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
        Z = cell2mat(varargin(1)); %atomic number
        if Z > 112
            error("Input atomic number less than 113")
        else
            mass = m_sef(round(table2array(table(Z, 4))), Z);
            varargout{1} = mass;
           
            struct = table2struct(table(Z,:));
            varargout{2} = struct;
        end
        
    case 2        
        a = isa(varargin{1}, 'numeric');
        b = isa(varargin{1}, 'char');
        c = isa(varargin{1}, 'string');
        d = isa(varargin{2}, 'numeric');
        e = isa(varargin{2}, 'char');
        f = isa(varargin{2}, 'string');
      
        if a==1 && d==1
            if (varargin{1} > varargin{2}) == 1
                A = varargin{1}; %number of nucleons
                Z = varargin{2}; %atomic number
            else %(varargin{1} <= varargin{2}) == 1 
                Z = varargin{1}; %atomic number
                A = varargin{2}; %number of nucleons
            end
            
            mass = m_sef(A, Z);
            varargout{1} = mass;
            
            %determine if stable using EB: if element is stable the binding
            %energy is positive
            s = EB(A, Z)
            if s>0
                stability = "stable";
            else %s<=0
                stability = "not stable";
            end
            varargout{2} = stability;
            
        elseif (a==1 && e==1) || (a==1 && f==1) || (b==1 && d==1) || (c==1 && d==1)
            varargout{1} = "char";
            if (a==1 && e==1)
                Z = varargin{1};
                field = varargin{2};
            elseif (a==1 && f==1)
                Z = varargin{1};
                field = varargin{2};
            elseif (b==1 && d==1)
                field = varargin{1};
                Z = varargin{2};
            else %(c==1 && d==1)
                field = varargin{1};
                Z = varargin{2};
            end
            
            mass = m_sef(round(table2array(table(Z, 4))), Z);
            varargout{1} = mass;
            
            value = table{Z, field};
            varargout{2} = value;
        else
            error("If two arguments are input, at least one must be a number")
        end
end
end