global i
global fnome
global hist;
global qt;
global hist_filt;
global show_select;
global cont_hist;


cont_imag = 2000;
cont_hist = 200;
show_select=1000;
qt = 0;

clear();
clearvars();

%%Nome dos algoritmos
filtros;
%%Menu principal
f = figure;
i = imread("btn.png");

%%Painel para agrupar botoes
p = uipanel("title", " ▷ Carregar Imagem ◁ ", "position", [.0 .84 1 0.16]);
p2 = uipanel("title", " ▷ Escolher Filtro ◁ ", "position", [.0 -.013 1 0.85]);

%%Botoes do menu
b1 = uicontrol("parent", p, "string", "Imagem Original","position", [10 10 150 30],'callback',(@ShowImage));
b2 = uicontrol("parent", p, "string", "Carregar Arquivo","position",[170 10 150 30],'callback',(@LoadImage));
b3 = uicontrol("parent", p, "string", "Histórico","position",[330 10 150 30],'callback',(@Historico));
b0 = uicontrol("parent", p, "string", "Show N","position",[485 10 60 30],'callback',(@ShowN));
%Filtros
b4 = uicontrol("parent", p2, "string", "✩Limiarizaçao ","position",[10 295 150 30],'callback',(@Limiarizacao));
b5 = uicontrol("parent", p2, "string","✩Escala de Cinza","position", [10 260 150 30],'callback',(@EscalaCinza));
b6 = uicontrol("parent", p2, "string", "✩Passa Alta-Básico","position",[10 225 150 30],'callback',(@PassaAlta));
b7 = uicontrol("parent", p2, "string","✩Ref Passa Alta","position", [10 190 150 30],'callback',(@ReforcoPassaAlta));
b8 = uicontrol("parent", p2, "string","✩Média","position", [10 155 150 30],'callback',(@Media));
b9 = uicontrol("parent", p2, "string","✩Mediana","position", [10 120 150 30],'callback',(@Mediana));

b9 = uicontrol("parent", p2, "string", "✩Prewitt ","position", [10 85 150 30],'callback',(@Prewitt));
b10 = uicontrol("parent", p2, "string", "✩Sobel","position",[170 295 150 30],'callback',(@Sobel));
b11 = uicontrol("parent", p2, "string", "✩PrewittVH","position",[170 260 150 30],'callback',(@PrewittHV));

b12 = uicontrol("parent", p2, "string", "✩Sobel HV","position",[170 225 150 30],'callback',(@SobelHV));
b13 = uicontrol("parent", p2, "string", "✩IMG1 + IMG2","position",[330 295 150 30],'callback',(@SomaIMG));
b16 = uicontrol("parent", p2, "string","✩IMG1 - IMG2","position", [330 260 150 30],'callback',(@SubIMG));
b14 = uicontrol("parent", p2 ,"string","✩Roberts","position",[170 155 150 30],'callback',(@Roberts));
b15 = uicontrol("parent", p2, "string","✩Filt Edge","position", [170 190 150 30],'callback',(@Edge));
b16 = uicontrol("parent", p2, "string","✩Histograma","position", [330 225 150 30],'callback',(@Histograma));
b17 = uicontrol("parent", p2, "string","✩Salt & Papper","position", [170 120 150 30],'callback',(@SaltPapper));
b18 = uicontrol("parent", p2, "string","✩Speckle","position", [170 85 150 30],'callback',(@Speckle));
b19 = uicontrol("parent", p2, "string","✩Poisson","position", [330 190 150 30],'callback',(@Poisson));
b20 = uicontrol("parent", p2, "string","✩Gaussian","position", [330 155 150 30],'callback',(@Gaussian));
b21 = uicontrol("parent", p2, "string","✩Watershed","position", [330 120 150 30],'callback',(@Watershed));
b22 = uicontrol("parent", p2, "string","✩Zerocross","position", [330 85 150 30],'callback',(@Zerocross));
b23 = uicontrol("parent", p2, "string","✩IMG * x","position", [330 50 150 30],'callback',(@IMGmult));
b24 = uicontrol("parent", p2, "string","✩FiltFspecial","position", [170 50 150 30],'callback',(@FiltFspecial));
b25 = uicontrol("parent", p2, "string","✩~IMG","position", [10 50 150 30],'callback',(@InvertIMG));
b26 = uicontrol("parent", p2, "string","✩Mov N->I","position", [10 15 150 30],'callback',(@MovIN));
b27 = uicontrol("parent", p2, "string","✩Ajuste Hist","position", [10 15 150 30],'callback',(@AjustHist));
b28 = uicontrol("parent", p2, "string","✩Imfill","position", [170 15 150 30],'callback',(@Imfill_h));
b29 = uicontrol("parent", p2, "string","✩Bwareaopen","position", [170 15 150 30],'callback',(@Bwareaopen_h));
b30 = uicontrol("parent", p2, "string","✩RecObjetos","position", [330 15 150 30],'callback',(@RecObjetos));
