%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                %
%                  GABRIEL FERNANDES ROCATELLI                   %
%             IMPLEMENTAÇÃO MÉTODO ELEMENTOS FINITOS             %
%                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DADOS
Dados


%% PROCESSAMENTO 


        % INCIDENCIA NODAL 


for i=1:elementnumber
inci(i,:)=[ i  i+1];    %identificação da localização de cada elemento - elemento 1 nós 1 e 2; elemento 2 nós 2 e 3; elemento 3 nós 3 e 4; elemento 4 nós 4 e 5.
end

        % METODO DIFERENCIAL
        
        
syms csi 

Nii = (1-csi)/2;
Njj = ((1+csi)/2); 
Ni = (diff(Nii)); %ao inves de usar o diferencial, é mais interessante usar a evidencia de valores dentro da matriz calculada e implementar os termos simplificados
Nj = (diff(Njj));

% Nfun = 


        

        %MATRIZ DE RIGIDEZ LOCAL E GLOBAL

        %MATRIZ DE RIGIDEZ LOCAL E GLOBAL
       
        
        KG = zeros(nos,nos); %matriz zero que representa a matriz global em dimensões
        
%         NumInt = ('Grau da função de forma: ')
%         NumInt = input(NumInt)
          NumInt = 1;
        
        [xi , wi] = gauss_quadra(NumInt); %CHAMADA DA FUNÇÃO DAS COORDENADAS DE GAUSS QUE RETORNA OS VALORES DE xi E wi DE ACORDO COM O GRAU DA FUNÇÃO DE FORMA
        
        Ke = zeros(2,2); 
        
        
        
for e=1:elementnumber
 
     % MATRIZ LOCAL
        
         Ke(:,:,e) = (B') * (E*A) * (B) * (wi) * (1/J);
       
     % SUPERPOSIÇÃO - MATRIZ GLOBAL
         
         loc=[inci(e,1) inci(e,2)]; %posição na qual os elementos entrarão na matriz de rigidez global
         KG(loc,loc) = KG(loc,loc) + Ke(:,:,e); %matriz global
end
% KG = zeros(nos,nos); %matriz zero que representa a matriz global em dimensões
%  for i=1:elementnumber
%      
%      % MATRIZ LOCAL
%      Ke = zeros(2,2);
%      Ke(:,:,i) = (2*A*E*(2/L))*mrigidez;
%      
%      % Superposição
%      loc=[inci(i,1) inci(i,2)]; %posição na qual os elementos entrarão na matriz de rigidez global
%      KG(loc,loc) = KG(loc,loc) + Ke(:,:,i); %matriz global
%      
%  end
 
 
        % Condições de contorno naturais

 
KG(1,1) = KG(1,1)+k1;
KG(nos,nos) = KG(nos,nos)+k2;
 

        % CARREGAMENTO
        
        
k=1/4; %coordenada x2 do nó
j=0; %coordenada x1 do nó
for i=1:elementnumber
    T(i)=(10*((j/2) - ((j*csi)/2) + (k/2) + ((k*csi)/2))) - 2; 
    k=k+1/4;
    j=j+1/4;
    
    Fi(i)=(int(T(i)*Nii*(1/8),-1,1)); %laço que calcula a força aplicada na posição Ni.
    Fj(i)=(int(T(i)*Njj*(1/8),-1,1)); %laço que calcula a força aplicada na posição Nj.
        
    
        if i==4
            Fj(i)=Fj(i) - k2 * 0.1 * 1; %condição de contorno na extremidade direita
        end
end
%uma vez com o T avaliado nos índices dos elementos, pode-se implementar a
%força aplicada nos nós a partir da aproximação de Galerkin



        % EQUILÍBRIO DE FORÇAS APLICADAS NOS NÓS


F=zeros(5,1); %matriz que representa as dimensões da força em cada nó. Implementada como matriz ao invés de vetor
F(1,1)=Fi(1);
F(2,1)=Fi(2) + Fj(1);
F(3,1)=Fi(3) + Fj(2);
F(4,1)=Fi(4) + Fj(3);
F(5,1)= Fj(4);



%% PÓS PROCESSAMENTO
%POR FIM, OS DESLOCAMENTOS PODEM SER LOCALIZADOS ATRAVÉS DO SISTEMA LINEAR:


format long
U = KG\F;
U


%% %PÓS-PROCESSAMENTO


syms x
 for i=1:elementnumber
     N(i,:) = [i-(x/Le),4*x+1-i]; %declaração da função N(x)
 end

%% DEFORMAÇÃO ELEMENTAR PARA UMA COLETÂNEA DE VALORES X (COORDENADAS)
for e=1:elementnumber
loc=[inci(e,1) inci(e,2)];
U = U(inci);
U_element = U(loc);
U_element = U_element';
u_element(e,:) = [dN1 dN2]*U_element; %deformação no elemento
coord = [0 0.25 0.5 0.75 1];
end

u_plot_1 = [269/2720 43/102]; %VETOR QUE RECEBE OS COEFICIENTES DAS FUNÇÕES A FIM DE AVALIA-LAS EM CADA VALOR DE X
x = coord;
y_plot_1 = polyval(u_plot_1,x);
y_plot_1 = y_plot_1';

u_plot_2 = [47/544 6931/16320];
y_plot_2 = polyval(u_plot_2,x);
y_plot_2 = y_plot_2';

u_plot_3 = [31/2720 7543/16320];
y_plot_3 = polyval(u_plot_3,x);
y_plot_3 = y_plot_3';

u_plot_4 = [17759/32640 133/1360];
y_plot_4 = polyval(u_plot_4,x);
y_plot_4 = y_plot_4';


U_plot = zeros(20,1); %CRIAÇÃO DO VETOR PARA PLOTAGEM DE DEFORMAÇÃO

for i=1:5
    U_plot(i) = U_plot(i) + y_plot_1(i);
end

for i=6:10
    U_plot(i) = U_plot(i) + y_plot_2(i-5);
end
for i=11:15
    U_plot(i) = U_plot(i) + y_plot_3(i-10);
end
for i=16:20
    U_plot(i) = U_plot(i) + y_plot_4(i-15);
end

% figure
% x_coord = [1:1:20];
% plot(x_coord,U_plot);

%[F]= gauss_quadra(@(x) x^2+3*x,-1,1,3)
%% Tensão do elemento para um dado valor de x
% for i=1:elementnumber
% 
%     Tensao(i) = diff(u(i))
%     Tensao(i) = Tensao(i)*E(i)
% 
% end
% coord=[0 0.25 0.50 0.75 1.0;]

% 
% figure; hold on
% fplot(@(x)(269.*x)./2720+43./102 , [0,10])
% fplot(@(x)(47*x)/544 + 6931/16320,  [10,20])
% fplot(@(x)(31*x)/2720 + (7543/16320),  [20,30])
% fplot(@(x)17759/32640 - ((133*x)/1360),  [30,40])
% 

% U = KG\F;
% figure
% plot(coord, U)
% plot(coord, Tensao)
%professor roberto  daledone machado marcos ardnt 

