global i
global fpath
global fnome
global hist;
global qt;
global hist_filt;
global show_select;

show_select=1000;
qt = 0;

clear();
clearvars();

%%Nome dos algoritmos
Filtros;
%%Menu principal
f = figure;
i = imread("btn.png");

%%Painel para agrupar botoes
p = uipanel("title", " ▷ Carregar Imagem ◁ ", "position", [.0 .84 1 0.16]);
p2 = uipanel("title", " ▷ Escolher Filtro ◁ ", "position", [.0 -.013 1 0.85]);

%%Botoes do menu
b1 = uicontrol("parent", p, "string", "Imagem Original","position", [10 10 150 30],'callback',(@ShowImage));
b2 = uicontrol("parent", p, "string", "Carregar Arquivo","position",[170 10 150 30],'callback',(@LoadImage));
b3 = uicontrol("parent", p, "string", "Historico","position",[330 10 150 30],'callback',(@Historico));
b0 = uicontrol("parent", p, "string", "Show N","position",[485 10 60 30],'callback',(@ShowN));
%Filtros
b4 = uicontrol("parent", p2, "string", "✩Limiarizaçao ","position",[10 295 150 30],'callback',(@Limiarizacao));
b5 = uicontrol("parent", p2, "string","✩Escala de Cinza","position", [10 250 150 30],'callback',(@EscalaCinza));
b6 = uicontrol("parent", p2, "string", "✩Passa Alta-Básico","position",[10 205 150 30],'callback',(@PassaAlta));
b7 = uicontrol("parent", p2, "string","✩Ref Passa Alta","position", [10 160 150 30],'callback',(@ReforcoPassaAlta));
b8 = uicontrol("parent", p2, "string","✩Média","position", [10 115 150 30],'callback',(@Media));
b9 = uicontrol("parent", p2, "string","✩Mediana","position", [10 70 150 30],'callback',(@Mediana));

b9 = uicontrol("parent", p2, "string", "✩Prewitt ","position", [10 26 150 30],'callback',(@Prewitt));
b10 = uicontrol("parent", p2, "string", "✩Sobel","position",[170 295 150 30],'callback',(@Sobel));
b11 = uicontrol("parent", p2, "string", "✩PrewittVH","position",[170 250 150 30],'callback',(@PrewittHV));

b12 = uicontrol("parent", p2, "string", "✩Sobel HV","position",[170 205 150 30],'callback',(@SobelHV));
b13 = uicontrol("parent", p2, "string", "✩IMG1 + IMG2","position",[330 295 150 30],'callback',(@SomaIMG));
b16 = uicontrol("parent", p2, "string","✩IMG1 - IMG2","position", [330 250 150 30],'callback',(@SubIMG));
b14 = uicontrol("parent", p2 ,"string","✩Roberts","position",[170 115 150 30],'callback',(@Roberts));
b15 = uicontrol("parent", p2, "string","✩Filt Edge","position", [170 160 150 30],'callback',(@Edge));
b16 = uicontrol("parent", p2, "string","✩Histograma","position", [330 205 150 30],'callback',(@Histograma));
b17 = uicontrol("parent", p2, "string","✩Salt & Papper","position", [170 70 150 30],'callback',(@SaltPapper));
b18 = uicontrol("parent", p2, "string","✩Speckle","position", [170 26 150 30],'callback',(@Speckle));
b19 = uicontrol("parent", p2, "string","✩Poisson","position", [330 160 150 30],'callback',(@Poisson));
b19 = uicontrol("parent", p2, "string","✩Gaussian","position", [330 115 150 30],'callback',(@Gaussian));

