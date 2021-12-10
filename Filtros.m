pkg load image  %%Pacote para manupulação de imagens
%%Mostrar Historico
function Historico()
  global hist;
  global qt;
  global i;
  global hist_filt;
  
  
  if(qt == 0)
    warndlg ("Sem historico de operações.");
  else
    t = qt;
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


%%Mostrar Historico
function Histograma()
  global hist;
  global qt;
  global i;
  global hist_filt;
  
  
  if(qt == 0)
    warndlg ("Sem historico de operações.");
  else
    t = qt;
     for x = 1:t;
      list_option{x} = strcat(num2str(x)," - ",hist_filt{x});
      disp(list_option{x});
    endfor
   
    [sel, ok] = listdlg ("ListString", list_option,"SelectionMode","Single");  

    if(ok == 1)
      figure(2000),imhist(hist{sel});
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

%%Mostrar Historico
function ShowN()
  global hist;
  global qt;
  global i;
  global hist_filt;
  global show_select;
  t = qt;
  
  if(t == 0)
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
      figure(show_select), subplot(1,1,1);imshow(hist{sel},"papersize", [50, 100]);
      title(hist_filt{sel});
      show_select++;
    endif
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
      figure(2), subplot(1,1,1);imshow(i);
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
   
        i = rgb2gray(i);
        figure(2), subplot(1,1,1);imshow(i);
        title("Escala de Cinza");
      
        %%Armazena historico
        qt = qt+1;
        hist{qt} = i;
        hist_filt{qt} = "Escala de Cinza";  
    
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
      i = medfilt2(i,true(mat_t));
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Mediana =",num2str(mat_t)));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
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


%%PrewittHV
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
      title(strcat ("Prewitt HV"));
      
      %%Armazena historico
      disp("----");
      disp(qt);
      qt = qt+1;
      disp(qt);
      hist{qt} = i;
      hist_filt{qt} = "Prewitt HV";  
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



%%SobelHV
function SobelHV()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
       
      % %Aplica Prewitt
      h = fspecial('sobel')
      
      i = imfilter(i,h);
      i2 = imfilter(i,h');
      
      i = i+i2;
 
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Sobel HV"));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Sobel HV";  
     endif
end



%%SobelHV
function SomaIMG()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
   else
       
    t = qt;
 
    for x = 1:t;
    list_option{x} = strcat(num2str(x)," - ",hist_filt{x});
    disp(list_option{x});
    endfor
   
    [sel1, ok1] = listdlg ("ListString", list_option,"SelectionMode","Single");  
    [sel2, ok2] = listdlg ("ListString", list_option,"SelectionMode","Single");  
    
    
    if((ok1 + ok2) == 2)
        Y = hist{sel1};
        Z = hist{sel2};
        
        figure(99),imshow(Y);
        figure(999),imshow(Z);
        
        i = Y+Z;    
        figure(2), subplot(1,1,1);imshow(i);
        title("IMG1 + IMG2");
        disp("----");
        disp(qt);
        qt = qt+1;
        disp(qt);
        disp("---");
        hist{qt} = i;
        hist_filt{qt} = "IMG1 + IMG2";   
   else
        warndlg ("É necessario ter duas imagens selecionados.");
   endif
  endif
end


%%SobelHV
function SubIMG()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
   else
       
    t = qt;
 
    for x = 1:t;
    list_option{x} = strcat(num2str(x)," - ",hist_filt{x});
    disp(list_option{x});
    endfor
   
    [sel1, ok1] = listdlg ("ListString", list_option,"SelectionMode","Single");  
    [sel2, ok2] = listdlg ("ListString", list_option,"SelectionMode","Single");  
    
    
    if((ok1 + ok2) == 2)
        Y = hist{sel1};
        Z = hist{sel2};
        
        figure(99),imshow(Y);
        figure(999),imshow(Z);
        
        i = Y-Z;    
        figure(2), subplot(1,1,1);imshow(i);
        title("IMG1 - IMG2");
        disp("----");
        disp(qt);
        qt = qt+1;
        disp(qt);
        disp("---");
        hist{qt} = i;
        hist_filt{qt} = "IMG1 - IMG2";   
   else
        warndlg ("É necessario ter duas imagens selecionados.");
   endif
  endif
end


%%ROberts
function Roberts()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
   else
      % %Aplica media
      i = edge(i,'roberts');
  
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Roberts"));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Roberts";  
     endif
end

%%Edge
function Edge()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
    list = {"roberts","prewitt","sobel","canny","log"};
   
    [sel, ok] = listdlg ("ListString", list,"SelectionMode","Single");  
  
    if(ok == 1)
       % %Aplica media
      i = edge(i,list{sel});
  
      figure(2), subplot(1,1,1);imshow(i);
      title(list{sel});
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = list{sel};  
      
    endif
  endif
end

%%SaltPapper
function SaltPapper()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
         
     %% Cria Caixa de configuração
     prompt = {"Salt & Papper"};
     defaults = {"1"};
     rowscols = [1,10];
     conf = inputdlg (prompt, "Density", ...
                     rowscols, defaults);
     disp(isempty(conf));
     
     if(isempty(conf) == 1)
        dens = 1;
      else  
        dens = str2num(conf{1,1});
      endif
      % %Aplica ruido
      i =  imnoise (i, "salt & pepper", dens);
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Salt & Papper D=",num2str(dens)));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Salt & Papper";  
     endif
end


%%Speckle
function Speckle()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
         
     %% Cria Caixa de configuração
     prompt = {"Speckle"};
     defaults = {"1"};
     rowscols = [1,10];
     conf = inputdlg (prompt, "Variance", ...
                     rowscols, defaults);
     disp(isempty(conf));
     
     if(isempty(conf) == 1)
        varia = 1;
      else  
        varia = str2num(conf{1,1});
      endif
      % %Aplica ruido
      i =  imnoise (i, "speckle", varia);
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Variance D=",num2str(varia)));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Variance";  
     endif
end

%%poisson
function Poisson()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
 
      % %Aplica ruido
      i =  imnoise (i,"poisson");
      
      figure(2), subplot(1,1,1);imshow(i);
      title("Poisson");
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Poisson";  
     endif
end


%%Gaussian
function Gaussian()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
   else
         
     %% Cria Caixa de configuração
     prompt = {"Mean[0,1]","Variance[0.1]"};
     defaults = {"0.5","0.5"};
     rowscols = [1,7; 1,7];
     conf = inputdlg (prompt, "Gaussian", ...
                     rowscols, defaults);
    
    
     if(isempty(conf) == 1)
        mean = 0.5;
        variance =0.5;

      else  
        mean = str2num(conf{1,1});
        variance = str2num(conf{2,1});
        
      endif  
    

      i = imnoise(i,"gaussian",mean,variance);

      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Gaussian"," Mean =",num2str(mean),"| Variance =",num2str(variance)));

      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Gaussian";  
     endif
end


%%Watershed
function Watershed()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
   else
         
     %% Cria Caixa de configuração
     prompt = {"con [4 6 8 18 26]"};
     defaults = {"4"};
     rowscols = [1,7];
     conf = inputdlg (prompt, "Watershed", ...
                     rowscols, defaults);
    
    
     if(isempty(conf) == 1)
        conn = 4;
       

      else  
        conn = str2num(conf{1,1});
  
        
      endif  
    

      i =watershed (i,conn);

      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Watershed",",conn =",num2str(conn)));

      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Watershed";  
     endif
end


%%zerocross
function Zerocross()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
    list = {"average","disk","gaussian","log","laplacian","unsharp","motion","sobel","prewitt","kirsch"};
   
    [sel, ok] = listdlg ("ListString", list,"SelectionMode","Single");  
  
    if(ok == 1)
       %% Cria Caixa de configuração
     prompt = {"thresh"};
     defaults = {"0"};
     rowscols = [1,7];
     conf = inputdlg (prompt, "zerocross", ...
                     rowscols, defaults);
    
    
     if(isempty(conf) == 1)
        thresh = 0;
      else  
        thresh = str2num(conf{1,1});
      endif  
    
       % %Aplica media
       i = rgb2gray(i)
       h = fspecial(list{sel});
       i = edge(i,'zerocross',thresh,h);
  
      figure(2), subplot(1,1,1);imshow(i);
      title("zerocross");
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "zerocross";  
      
    endif
  endif
end






##
##I = imread('rosto.jpeg');
####figure, imshow(I);
####title('Original');
####I =  watershed (I,3);
####figure, imshow(I);
####title('zerocross');
##
##
##H = [-1/9 -1/9 -1/9;-1/9 8/9 -1/9;-1/9 -1/9 -1/9;]
##    j = edge(rgb2gray(I),'zerocross',0,H);
##figure(444), imshow(j);




