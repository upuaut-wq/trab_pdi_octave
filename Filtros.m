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
      i = hist(sel);
      qt = sel;
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
    figure, subplot(1,1,1);imshow(hist{1});
    title(hist_filt{1});
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
    figure, subplot(1,1,1);imshow(i);
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
        figure, subplot(1,1,1);imshow(i);
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
     

     
     if(isempty(conf) == 0)
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
      figure, subplot(1,1,1);imshow(i);
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
      
      figure, subplot(1,1,1);imshow(i);
      title(strcat ("Reforço de Imagem"," PA*",num2str(mult),"| A-",num2str(multImg),"*I+IO"));

      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Reforço Passa Alta";  
     endif
end












