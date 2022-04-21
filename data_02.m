%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                %
%                  GABRIEL FERNANDES ROCATELLI                   %
%             IMPLEMENTAÇÃO MÉTODO ELEMENTOS FINITOS             %
%                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PRÉ-PROCESSAMENTO (DADOS)
clc;clear all;close all;

elementnumber = 4;       % Número de elementos

nos = elementnumber + 1; % Número de nós

k1 = 2;                  % Constante da mola 1 - extremidade esquerda N/mm

k2 = 4;                  % Constante da mola 2 - extremidade direita N/mm

L = 1;                   % Tamanho da barra

Le = 1/4;                % Tamanho do elemento

E = 2;                   % Módulo de Young

A = 5;                   % Área 

dN1 = -1/2;              % Derivada da função de forma relativo ao primeiro nó

dN2 = 1/2;               % Derivada da função de forma relativo ao segundo nó

B = [dN1 dN2];

J = Le / 2;              % Caso 1D - No entanto, será necessário a criação a de uma function que calcula o valor de J para diferentes problemas

x_car = @(b)  10*b - 2;