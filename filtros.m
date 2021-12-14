pkg load image  

ui;
%%Mostrar Historico
function Historico()
  global hist;
  global qt;
  global i;
  global hist_filt;
  
  
  if(qt == 0)
    warndlg ("Sem historico de operações.");
  else
    [sel, ok] = @select_img_hist("Voltar até?")
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
function MovIN()
  global hist;
  global qt;
  global i;
  global hist_filt;
  
  
  if(qt == 0)
    warndlg ("Sem historico de operações.");
  else
    [sel, ok] = @select_img_hist("Mover para I?")
    disp(sel);
    disp(ok);
    if(ok == 1)
      i = hist{sel};S
      
     figure(2), subplot(1,1,1);imshow(i);
      title("Mov N->I");
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Mov N->I";  
    endif
  endif
end


%%Mostrar Histograma
function Histograma()
  global hist;
  global qt;
  global i;
  global hist_filt;
  
  
  if(qt == 0)
    warndlg ("Sem historico de operações.");
  else
   
   
    [sel, ok] = @select_img_hist("Imagem para Histograma.")

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
    
   
    [sel, ok] = @select_img_hist("Mostrar Imagem.")
    disp(sel);
    disp(ok);
    if(ok == 1)
      figure(show_select), subplot(1,1,1);imshow(hist{sel});
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
     conf = @entry_value("Limiar",{"Limiar:[0 1]"},{"0.5"},[1,7]);
     
     disp(conf);
     if(isempty(conf) == 1)
        limiar = 0.5;
      else  
        limiar = str2num(conf{1,1});
      endif
      try
      i = im2bw(i,limiar);
    catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
    
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
        try
        i = rgb2gray(i);
          catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
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
     conf = @entry_value("Passa Alta",{"Tamanho matriz","PA*X"},{"3","1"},[1,7; 1,7]);
     if(isempty(conf) == 1)
        tam = 3;
        mult = 1;
      else  
        tam = str2num(conf{1,1});
        mult = str2num(conf{2,1});
      endif  
      disp(tam);
      disp(mult);
      
      for f = 1:tam
          for g = 1:tam
              h(f,g) = -1/(tam*tam);
          endfor
      endfor
      
      h(ceil(tam/2),ceil(tam/2)) = ((tam*tam)-1)/(tam*tam);
      
      disp(h);
      try
      i = imfilter(i,h)*mult;
        catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
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
     conf = @entry_value("Passa Alta",{"Tamanho matriz","PA*X","(A-X)*I+PA"},{"3","1","1"},[1,7; 1,7;1,7]);
  
     %%Imagem para mistura do reforço
     [sel, ok] = @select_img_hist("Imagem para Reforço.")
    
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
      
       for f = 1:tam
          for g = 1:tam
              h(f,g) = -1/(tam*tam);
          endfor
      endfor
      
      h(ceil(tam/2),ceil(tam/2)) = ((tam*tam)-1)/(tam*tam);
      try
      i = imfilter(i,h)*mult;
        catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
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
     conf = @entry_value("Media",{"Tamanho matriz"},{"3"},[1,7]);
 
     disp(isempty(conf));
     if(isempty(conf) == 1)
        mat_t = 3;
      else  
        mat_t = str2num(conf{1,1});
      endif
      
      % %Aplica media
      try
      h = fspecial('average',mat_t)
      i = imfilter(i,h);
        catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
      
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
     conf = @entry_value("Mediana",{"Tamanho matriz"},{"3"},[1,7]);
     
     if(isempty(conf) == 1)
        mat_t = 3;
      else  
        mat_t = str2num(conf{1,1});
      endif
      disp(mat_t);
      % %Aplica media
      try
      i = medfilt2(i,true(mat_t));
        catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat ("Mediana =",num2str(mat_t)));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "Mediana";  
      #i = i2;
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
      
     try
      i = imfilter(i,h);
         catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
      
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
      try
      h = fspecial('prewitt')
      
 
      i = imfilter(i,h);
      i2 = imfilter(i,h');
      
      i = i+i2;
         catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
 
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
      try
      h = fspecial('sobel');
         catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
      
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
      try
      h = fspecial('sobel')
      
      i = imfilter(i,h);
      i2 = imfilter(i,h');
         catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
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
       
  
   
    [sel1, ok1] = @select_img_hist("Imagem 1")  
    [sel2, ok2] = @select_img_hist("Imagem 2")  
      
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
       
    
   
    [sel1, ok1] = @select_img_hist("Imagem 1")  
    [sel2, ok2] = @select_img_hist("Imagem 2")    
    
    
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
      try
      i = edge(i,'roberts');
           catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
  
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
   
    [sel, ok] = listdlg ("Name","Filtros Edge","ListString", list,"SelectionMode","Single");  
  
    if(ok == 1)
       % %Aplica media
       try
      i = edge(i,list{sel});
           catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
  
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
     conf = @entry_value("Salt & Papper",{"Density"},{"1"},[1,7]);
     
     if(isempty(conf) == 1)
        dens = 1;
      else  
        dens = str2num(conf{1,1});
      endif
      % %Aplica ruido
      try
        
      i =  imnoise (i, "salt & pepper", dens);
           catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
      
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
     conf = @entry_value("Variance",{"Speckle"},{"1"},[1,7]);
     
     if(isempty(conf) == 1)
        varia = 1;
      else  
        varia = str2num(conf{1,1});
      endif
      % %Aplica ruido
      try
      i =  imnoise (i, "speckle", varia);
           catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
      
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
      try
      i =  imnoise (i,"poisson");
           catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
      
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
     conf = @entry_value("Gaussian",{"Mean:[0,1]","Variance:[0.1]"},{"0.5","0.5"},[1,7; 1,7]);
    
     if(isempty(conf) == 1)
        mean = 0.5;
        variance =0.5;

      else  
        mean = str2num(conf{1,1});
        variance = str2num(conf{2,1});
        
      endif  
    
     try
      i = imnoise(i,"gaussian",mean,variance);
           catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch

      
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
      conf = @entry_value("Watershed",{"Con:[4 6 8 18 26]"},{"4"},[1,7]);

     if(isempty(conf) == 1)
        conn = 4;
       

      else  
        conn = str2num(conf{1,1});
  
        
      endif  
    
    try
      i =watershed (i,conn);
           catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch

      
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
   
    [sel, ok] = listdlg ("Name","Filtro de Argumento","ListString",list,"SelectionMode","Single");  
  
    if(ok == 1)
       %% Cria Caixa de configuração
     conf = @entry_value("Conf Thresh",{"Thresh"},{"0"},[1,7]);
    
     if(isempty(conf) == 1)
        thresh = 0;
      else  
        thresh = str2num(conf{1,1});
      endif  
    
       % %Aplica media
       try
       h = fspecial(list{sel});
       i = edge(i,'zerocross',thresh,h);
            catch 
        msg = lasterror.message;
        warndlg (msg);
        end_try_catch
  
      figure(2), subplot(1,1,1);imshow(i);
      title("zerocross");
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "zerocross";  
      
    endif
  endif
end


%%IMGmult
function IMGmult()
  global hist;
  global qt;
  global i;
  global hist_filt;
  
  
  if(qt == 0)
    warndlg ("Sem historico de operações.");
  else
  
    [sel, ok] = @select_img_hist("Imagem para Multiplicar.")  

    if(ok == 1)
       %% Cria Caixa de configuração
     conf = @entry_value("Conf Mult",{"Valor para Multiplicar"},{"1"},[1,7]);
    
     if(isempty(conf) == 1)
        mult = 0;
      else  
        mult = str2num(conf{1,1});
      endif  
      
      i = hist{sel}*mult;
      
      figure(2), subplot(1,1,1);imshow(i);
      title("IMGmult");
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = "IMGmult";  
    endif
  endif
end


%%FiltFspecial
function FiltFspecial()
  global hist;
  global qt;
  global i;
  global hist_filt;
  
  if(qt == 0)
    warndlg ("Sem historico de operações.");
  else
     list = {"average","disk","gaussian","log","laplacian","unsharp","motion","sobel","prewitt","kirsch"};
   
     [sel, ok] = listdlg ("Name","Filtro de Argumento","ListString",list,"SelectionMode","Single");      
  
  ##Average======================================================
  if(sel == 1)
      @imfilter_average();
  endif
  ##Disk======================================================
  if(sel == 2)
      @imfilter_disk();
  endif
  ##Gaussian======================================================
  if(sel == 3)
      @imfilter_gaussian();
  endif
  ##Log======================================================
   if(sel == 4)
      @imfilter_log();
  endif
   ##Laplacian======================================================
   if(sel == 5)
      @imfilter_laplacian();
  endif
  ##Unsharp======================================================
   if(sel == 6)
      @imfilter_laplacian();
  endif
   ##Motion======================================================
   if(sel == 7)
      @imfilter_motion();
  endif
   ##Sobel======================================================
   if(sel == 8)
      @imfilter_sobel();
  endif
   ##Prewitt======================================================
   if(sel == 9)
      @imfilter_prewitt();
  endif
  ##Prewitt======================================================
   if(sel == 10)
      @imfilter_kirsch();
  endif
  endif
end


%Disk
function imfilter_disk()
  global hist;
  global qt;
  global i;
  global hist_filt;
    conf = @entry_value("Disk",{"Matriz=ℕ"},{"3"},[1,7]);
     if(isempty(conf) == 1)
        mat = 3;
      else  
        mat = str2num(conf{1,1});
      endif  
    H = fspecial("disk",mat);
    
    list = {"s","symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Disk | M-",conf{1,1}," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Disk | M-",conf{1,1},"| p-",list{sel});  
endfunction


%Average
function imfilter_average()
  global hist;
  global qt;
  global i;
  global hist_filt;
    conf = @entry_value("Average",{"Matriz=ℕ"},{"3"},[1,7]);
     if(isempty(conf) == 1)
        mult = 3;
      else  
        mult = str2num(conf{1,1});
      endif  
    H = fspecial("average",mult);
    
    list = {"symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Average | M-",conf{1,1}," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Average | M-",conf{1,1},"| p-",list{sel});  
endfunction


%%Gaussian
function imfilter_gaussian()
  global hist;
  global qt;
  global i;
  global hist_filt;
    conf = @entry_value("Gaussian",{"Matriz=ℕ","Sigma=+ℝ"},{"3","1"},[1,7;1,7]);
     if(isempty(conf) == 1)
        mat = 3;
        sig = 1;
      else  
        mat = str2num(conf{1,1});
        sig = str2num(conf{2,1});
      endif  
    H = fspecial("disk",mat,sig);
    
    list = {"symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Disk | M-",conf{1,1}," Sig-",conf{2,1}," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Disk | M-",conf{1,1}," Sig-",conf{2,1}," | p-",list{sel});
endfunction

%%log
function imfilter_log() 
  global hist;
  global qt;
  global i;
  global hist_filt;
    conf = @entry_value("Log",{"Matriz=ℕ","Spread=[0 5]"},{"3","1"},[1,7;1,7]);
     if(isempty(conf) == 1)
        mat = 3;
        isp = 1;
      else  
        mat = str2num(conf{1,1});
        isp = str2num(conf{2,1});
      endif  
    H = fspecial("disk",mat,isp);
    
    list = {"symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Log | M-",conf{1,1}," Sp-",conf{2,1}," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} =strcat("Log | M-",conf{1,1}," Sp-",conf{2,1}," | p-",list{sel});
endfunction


%%Laplacian
function imfilter_laplacian()
  global hist;
  global qt;
  global i;
  global hist_filt;
    conf = @entry_value("Laplacian",{"Alfa=[0 1]"},{"0.2"},[1,7]);
     if(isempty(conf) == 1)
        alf = 0.2;
      else  
        alf = str2num(conf{1,1});
      endif  
    H = fspecial("Laplacian",alf);
    
    list = {"symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Laplacian | A-",conf{1,1}," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Laplacian | A-",conf{1,1},"| p-",list{sel});  
endfunction


%%unsharp
function imfilter_unsharp()
  global hist;
  global qt;
  global i;
  global hist_filt;
    conf = @entry_value("Unsharp",{"Alfa=[0 1]"},{"0.2"},[1,7]);
     if(isempty(conf) == 1)
        alf = 0.2;
      else  
        alf = str2num(conf{1,1});
      endif  
    H = fspecial("Unsharp",alf);
    
    list = {"symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Unsharp | A-",conf{1,1}," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Unsharp | A-",conf{1,1},"| p-",list{sel});  
endfunction


%%Motion
function imfilter_motion()
  global hist;
  global qt;
  global i;
  global hist_filt;
    conf = @entry_value("Motion",{"Comprimento=ℕ","Grau=+ℝ"},{"9","0"},[1,7;1,7]);
     if(isempty(conf) == 1)
        mat = 9;
        sig = 0;
      else  
        mat = str2num(conf{1,1});
        sig = str2num(conf{2,1});
      endif  
    H = fspecial("motion",mat,sig);
    
    list = {"symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Motion | C-",conf{1,1}," G-",conf{2,1}," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Motion | C-",conf{1,1}," G-",conf{2,1}," | p-",list{sel});
endfunction

%Sobel
function imfilter_sobel()
  global hist;
  global qt;
  global i;
  global hist_filt;
   
    H = fspecial("sobel");
    
    list = {"symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Disk | M-"," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Sobel","| p-",list{sel});  
endfunction


%Prewitt
function imfilter_prewitt()
  global hist;
  global qt;
  global i;
  global hist_filt;
   
    H = fspecial("prewitt");
    
    list = {"symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Prewitt"," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Prewitt ","| p-",list{sel});  
endfunction




%kirsch
function imfilter_kirsch()
  global hist;
  global qt;
  global i;
  global hist_filt;
   
    H = fspecial("kirsch");
    
    list = {"symmetric","replicate","circular","same","full","corr","conv"};
     [sel, ok] = @get_opt_imfilter();
     
     try
      if(ok == 1)
      
      disp(list{sel});
          i = imfilter(i,H,list{sel}); 
      else
          i = imfilter(i,H);
      endif
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Kirsch"," | p-",list{sel}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Kirsch ","| p-",list{sel});  
endfunction

function InvertIMG()
    global hist;
  global qt;
  global i;
  global hist_filt;
  try
  i = not(i);
catch
    msg = lasterror.message;
    warndlg (msg);
 end_try_catch
   figure(2), subplot(1,1,1);imshow(i);
   title(strcat("~IMG"," "));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("~IMG "," ");  
endfunction

%%AjustHist
function AjustHist()
  global hist;
  global qt;
  global i;
  global hist_filt;
  
  if(qt == 0)
    warndlg ("Sem historico de operações.");
  else
     list = {"Histeq","AdaptHisteq"};
   
     [sel, ok] = listdlg ("Name","Ajuste Histograma","ListString",list,"SelectionMode","Single");      
  
  ##Average======================================================
  if(sel == 1)
      @AjHisteq();
  endif
  ##Disk======================================================
  if(sel == 2)
      @AdHisteq();
  endif
  
  endif
end




%%AjHisteq
function AjHisteq()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
        try
        i = histeq(i);
          catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
        figure(2), subplot(1,1,1);imshow(i);
        title("Histeq");
      
        %%Armazena historico
        qt = qt+1;
        hist{qt} = i;
        hist_filt{qt} = "Histeq";  
    
   endif
end


%%AjHisteq
function AdHisteq()
 global i;
 global hist;
 global qt;
 global hist_filt;
 
   if(qt == 0)
    warndlg ("Sem imagem carregada.");
  else
        try
        i = adapthisteq(i);
    
        figure(2), subplot(1,1,1);imshow(i);
        title("Adapthisteq");
      
        %%Armazena historico
        qt = qt+1;
        hist{qt} = i;
        hist_filt{qt} = "Adapthisteq";  
              catch
      msg = lasterror.message;
      warndlg (msg);
    end_try_catch
    
   endif
end




%Imfill
function Imfill_h()
  global hist;
  global qt;
  global i;
  global hist_filt;
    conf = @entry_value("Imfill",{"Conn = [4 6 8 18 26]"},{"4"},[1,7]);
     if(isempty(conf) == 1)
        conn = 4;
      else  
        conn = str2num(conf{1,1});;
      endif  
     
     disp(conn)
     
     try
      i = imfill(i,conn,"holes"); 
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Holes |"," C-",conf{1,1}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Holes |"," C-",conf{1,1})
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
     
   
endfunction




%Bwareaopen
function Bwareaopen_h()
  global hist;
  global qt;
  global i;
  global hist_filt;
    conf = @entry_value("Imfill",{"PixelSize"},{"4"},[1,7]);
     if(isempty(conf) == 1)
        conn = 4;
      else  
        conn = str2num(conf{1,1});;
      endif  
     
     try
      i =  bwareaopen (i,conn)
      
      figure(2), subplot(1,1,1);imshow(i);
      title(strcat("Bwareaopen |"," P-",conf{1,1}));
      
      %%Armazena historico
      qt = qt+1;
      hist{qt} = i;
      hist_filt{qt} = strcat("Bwareaopen |"," P-",conf{1,1})
     catch 
        msg = lasterror.message;
        warndlg (msg);
     end_try_catch
 
     
   
endfunction


%Contagem objetos
function RecObjetos()
  global hist;
  global qt;
  global i;
  global hist_filt;
##     try


       

        i =  not(i);
        i=imclearborder(i);
    
        i2 =  bwboundaries(i);
        figure(10),imshow(hist{1});
        tam = length(i2);
        disp(tam);
        d = num2str(tam);
        title(strcat("Quantidade = ",d));
        hold on
       

        for k = 1:length(i2)
        boundary = i2{k};
        plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth',2)
         endfor
       
      
       
       
##     catch 
##        msg = lasterror.message;
##        warndlg (msg);
##     end_try_catch
     
   
endfunction

##%Contagem objetos
##function RecObjetos()
##  global hist;
##  global qt;
##  global i;
##  global hist_filt;
####     try
##
##
##    
##
##       i2 =  bwboundaries(i);
##       length(num2str(i2));
##       imshow(i);
##       disp(num2str(length(i2)));
##       title(strcat('\color{red}Quantidade de Objetos:',num2str(length(i2))));
##       hold on
##       
##       for k = 1:length(i2)
##        boundary = i2{k};
##        plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth',2)
##       endfor
##       
##       qt = qt+1;
##       hist{qt} = i;
##       hist_filt{qt} = strcat('\color{red}Quantidade de Objetos:',num2str(length(i2)));
##       
####     catch 
####        msg = lasterror.message;
####        warndlg (msg);
####     end_try_catch
##     
##   
##endfunction
