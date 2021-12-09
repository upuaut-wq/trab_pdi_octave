global i
global fpath
global fnome
global hist;
global qt;
global hist_filt;

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
b1 = uicontrol("parent", p, "string", "Imagem Original","position", [10 10 155 36],'callback',(@ShowImage));
b2 = uicontrol("parent", p, "string", "Carregar Arquivo","position",[170 10 155 36],'callback',(@LoadImage));
b3 = uicontrol("parent", p, "string", "Historico","position",[330 10 150 36],'callback',(@Historico));
b0 = uicontrol("parent", p, "string", "Show I","position",[485 10 60 36],'callback',(@ShowI));
%Filtros
b4 = uicontrol("parent", p2, "string", "✩Limiarizaçao ","position",[10 295 155 36],'callback',(@Limiarizacao));
b5 = uicontrol("parent", p2, "string","✩Escala de Cinza","position", [10 250 155 36],'callback',(@EscalaCinza));
b6 = uicontrol("parent", p2, "string", "✩Passa Alta-Básico","position",[10 205 155 36],'callback',(@PassaAlta));
b7 = uicontrol("parent", p2, "string","✩Ref Passa Alta","position", [10 160 155 36],'callback',({@ReforcoPassaAlta}));
%b8 = uicontrol("parent", p2, "string","✩Watershed","position", [10 115 155 36],'callback',({@Watershed}));
%b9 = uicontrol("parent", p2, "string","✩Contagem simples","position", [10 70 155 36],'callback',({@Contagem}));


%b9 = uicontrol("parent", p2, "string", "✩Prewitt ","position", [400 210 155 36],'callback',(@Prewitt));
%b10 = uicontrol("parent", p2, "string", "✩Sobel","position",[400 170 155 36],'callback',(@Sobel));
%b11 = uicontrol("parent", p2, "string", "✩Ajuste Histograma","position",[210 300 155 36],'callback',(@EquaHist));

%b12 = uicontrol("parent", p2, "string", "✩Passa Alta-Refor�o","position",[210 260 155 36],'callback',(i = @PassaAltaReforcada));
%b13 = uicontrol("parent", p2, "string", "✩Passa Baixa-B�sico","position",[210 220 155 36],'callback',(i = @PassaBaixa));
%b14 = uicontrol("parent", p2 ,"string","✩Passa Baixa Mediana","position",[210 180 155 36],'callback',(i = @PassaBaixaMediana));
%b15 = uicontrol("parent", p2, "string","✩Roberts","position", [400 250 155 36],'callback',({@Roberts}));
%b16 = uicontrol("parent", p2, "string","✩Zerocross","position", [400 90 155 36],'callback',({@Zerocross}));
%b17 = uicontrol("parent", p2, "string","✩Canny","position", [400 50 155 36],'callback',({@Canny}));
%b18 = uicontrol("parent", p2, "string","✩Log","position", [400 130 155 36],'callback',(@Log));
%b19 = uicontrol("parent", p2, "string","✩Histograma Simples","position", [210 90 155 36],'callback',(@histogramaSimples));

