pkg load image  %%Pacote para manupulação de imagens
%%Mostrar Historico
function Historico()
  global hist;
  global qt;
  global i;
  global hist_filt;
  t = qt;
  
  if(qt == 0)
    warndlg ("Sem historico de operações.");
  else
      for x = 1:t;
      list_option{x} = strcat(num2str(x)," - ",hist_filt{x});
      disp(list_option{x});
    endfor
   
    [sel, ok] = listdlg ("ListString", list_option,"SelectionMode","Single");  
    disp(sel);
    disp(ok);
    if(ok == 1)
      i = hist{sel};
      qt = sel;
      
      figure(2), subplot(1,1,1);imshow(hist{sel});
      title(hist_filt{sel});
    endif
  endif
end



%%Mostrar Imagem Carregada
function ShowImage()
  global hist;
  global qt;
  global hist_filt;
  
   if(qt == 0)
    warndlg ("Sem Sem imagem carregada.");
  else    
    figure(3), subplot(1,1,1);imshow(hist{1});
    title(hist_filt{1});
  endif
end

%%Mostrar Imagem Carregada
function ShowI()
  global hist;
  global qt;
  global i;
  global hist_filt;
  
   if(qt == 0)
    warndlg ("Sem Sem imagem carregada.");
  else    
    figure(2), subplot(1,1,1);imshow(i);
    title(hist_filt{qt});
  endif
end


%%Carregar arquivo
function LoadImage()
  global i;
  global fname;
  global hist;
  global qt;
  global hist_filt;
  
    fname = uigetfile("Selecione a Imagem");
    i = imread(fname);
    %%Armazena historico
    qt = 1;
    hist{qt} = i;
    hist_filt{qt} = "Imagem Original";
    %%mostra
    figure(2), subplot(1,1,1);imshow(i);
    title('Imagem Carregada');
end


%%Limiarização
function Limiarizacao()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
         
     %% Cria Caixa de configuração
     prompt = {"Limiar(threshold) - Valores entre [0 1]"};
     defaults = {"0.5"};
     rowscols = [1,10];
     conf = inputdlg (prompt, "Limiar", ...
                     rowscols, defaults);
     disp(isempty(conf));
     if(isempty(conf) == 1)
        limiar = 0.5;
      else  
        limiar = str2num(conf{1,1});
      endif
      
      i = im2bw(i,limiar);
      figure, subplot(1,1,1);imshow(i);
      title(strcat ("Limiar =",num2str(limiar)));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Limiarização";  
     endif
end




%%Escala de cinza
function EscalaCinza()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
      if (isrgb(i) == true)
        i = rgb2gray(i);
        figure(2), subplot(1,1,1);imshow(i);
        title("Escala de Cinza");
      
        %%Armazena historico
        qt = qt+1;
        hist{qt} = i;
        hist_filt{qt} = "Escala de Cinza";  
      else
         warndlg ("Imagem ja esta em Escala de Cinza."); 
     endif
   endif
end







%%Passa alta
function PassaAlta()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
   else
         
     %% Cria Caixa de configuração
     prompt = {"Tamanho Filtro","Reforço"};
     defaults = {"3","1"};
     rowscols = [1,7; 1,7];
     conf = inputdlg (prompt, "Configuração Passa Alta", ...
                     rowscols, defaults);
     

     
     if(isempty(conf) == 1)
        tam = 3;
        mult = 1;
      else  
        tam = str2num(conf{1,1});
        mult = str2num(conf{2,1});
      endif  
      disp(tam);
      disp(mult);
      
      h = [-1/tam -1/tam -1/tam; -1/tam 8/tam -1/tam; -1/tam -1/tam -1/tam;];
      i = imfilter(i,h)*mult;
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Passa Alta =",num2str(tam)," | img*",num2str(mult)));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Passa Alta";  
     endif
end



%%Reforco Imagem passa Alta
function ReforcoPassaAlta()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
   else
         
     %% Cria Caixa de configuração
     prompt = {"Tamanho Filtro","PA*x","(A-x)"};
     defaults = {"3","1","1"};
     rowscols = [1,7; 1,7;1,7];
     conf = inputdlg (prompt, "Configuração Passa Alta", ...
                     rowscols, defaults);
     
     %%Imagem para mistura do reforço
     t = qt;
     for x = 1:t;
      list_option{x} = strcat(num2str(x)," - ",hist_filt{x});
      disp(list_option{x});
      endfor
   
      [sel, ok] = listdlg ("ListString", list_option,"SelectionMode","Single");  
    
      i2 = hist{sel};
    
     if(isempty(conf) == 1)
        tam = 3;
        mult = 1;
        multImg = 1;
      else  
        tam = str2num(conf{1,1});
        mult = str2num(conf{2,1});
        multImg = str2num(conf{3,1});
      endif  
      disp(tam);
      disp(mult);
      
      h = [-1/tam -1/tam -1/tam; -1/tam 8/tam -1/tam; -1/tam -1/tam -1/tam;];
      i = imfilter(i,h)*mult;
      
      A=2;
      i=(A-multImg)*i+i2;
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Reforço de Imagem"," PA*",num2str(mult),"| A-",num2str(multImg),"*I+IO"));

      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Reforço Passa Alta";  
     endif
end


%%Media
function Media()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
         
     %% Cria Caixa de configuração
     prompt = {"Tamanho matriz"};
     defaults = {"3"};
     rowscols = [1,10];
     conf = inputdlg (prompt, "Tamanho Matriz[3,5,7,9,11]", ...
                     rowscols, defaults);
     disp(isempty(conf));
     if(isempty(conf) == 1)
        mat_t = 3;
      else  
        mat_t = str2num(conf{1,1});
      endif
      
      % %Aplica media
      h = fspecial('average',mat_t)
      i = imfilter(i,h);
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Media =",num2str(mat_t)));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Media";  
     endif
end

%%Media
function Mediana()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
         
     %% Cria Caixa de configuração
     prompt = {"Tamanho matriz"};
     defaults = {"3"};
     rowscols = [1,10];
     conf = inputdlg (prompt, "Tamanho Matriz[3,5,7,9,11]", ...
                     rowscols, defaults);
     disp(isempty(conf));
     
     if(isempty(conf) == 1)
        mat_t = 3;
      else  
        mat_t = str2num(conf{1,1});
      endif
      disp(mat_t);
      % %Aplica media
      i = rgb2gray(i);
      i2 = medfilt2(i,true(mat_t));
      
      figure(2), subplot(1,1,1);imshow(i2);
      title(strcat ("Mediana =",num2str(mat_t)));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i2;
      hist_filt{qt} = "Mediana";  
      i = i2;
     endif
end


%%Prewitt
function Prewitt()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
    
      
      % %Aplica Prewitt
      h = fspecial('prewitt')
      
      %%Pergunta Traspor
      btn = questdlg ("Transpor Matriz?","Deseja Transpor Matriz?","Sim", "Não","Não");

      if(strcmp(btn,"Sim"))
          h = h';
      endif
      
     
      i = imfilter(i,h);
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Prewitt T=",btn));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Prewitt";  
     endif
end


%%Media
function PrewittHV()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
    
      
      % %Aplica Prewitt
      h = fspecial('prewitt')
      
 
      i = imfilter(i,h);
      i2 = imfilter(i,h');
      
      i = i+i2;
 
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Prewitt T=",btn));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Prewitt";  
     endif
end


%%Sobel
function Sobel()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
         
  
      
      % %Aplica media
      h = fspecial('sobel');
      
      %%Pergunta Traspor
      btn = questdlg ("Transpor Matriz?","Deseja Transpor Matriz?","Sim", "Não","Não");

      if(strcmp(btn,"Sim"))
          h = h';
      endif
      
      
      disp(h);
      i = imfilter(i,h);
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Sobel,T=",btn));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Sobel";  
     endif
end



% median
%I = imread('cap.jpeg');
%I = rgb2gray(I);
%med= medfilt2(I,true(20));
%figure(5);
%imshow(med);
%title('Mediana');
%zoom(1.2);
%% PB(media) e Mediana




