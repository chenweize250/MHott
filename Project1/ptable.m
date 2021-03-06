function [varargout] = ptable(varargin)
%Case 1: No inputs returns plots of mass (calculated from both atomic
%weight and the semi-empircal formula) vs atomic number and binding 
%energy per nucleon vs atomic number
%Case 2: 1 input of an atomic number returns the mass and a structure
%containing information about the element
%Case 3: 2 inputs of atomic number and number of nucleons returns the mass
%and stability of the isotope
%Case 4: 2 inputs of atomic number and name of a field in the table returns
%the mass and information of the field from the table

csvfile = 'periodictabledata.csv';
table = readtable(csvfile);

%constants (units = MeV)
m_p = 938.272;
m_n = 939.566;
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

switch nargin
    case 0 %no inputs, outputs are graphs
        A = round(table2array(table(:, 4)))';%total number of nucleons
        Z = table2array(table(:, 1))';
        
        %mass calculated from atomic weight
        aw = table2array(table(:, 4))';
        m_aw = @(x) amu2MeV*x;
        
        %replace binding energy calculated for hydrogen with 0 
        benergy = EB(A, Z)./A;
        benergy(1) = 0;
        
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
        
        %plot of binding energy
        subplot(2,1,2); 
        plot(Z, benergy)
        title("Binding Energy Per Nucleon (MeV)")
        xlabel("Atomic Number")
        ylabel("Binding Energy")
   
    case 1 %input atomic number, output mass and struct
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
      
        if a==1 && d==1 %inputs are atomic number and nucleons, outputs are mass and stability
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
            s = EB(A, Z);
            if s>0
                stability = "stable";
            elseif (A == 1 && Z == 1) || (A == 2 && Z == 1) %hydrogen and deuterium
                stability = "stable";
            else %s<=0
                stability = "not stable";
            end
            varargout{2} = stability;
            
        elseif (a==1 && e==1) || (a==1 && f==1) || (b==1 && d==1) || (c==1 && d==1) %inputs are atomic number and field, outputs are mass and field value from table
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