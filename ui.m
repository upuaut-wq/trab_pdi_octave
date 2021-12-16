  pkg load image
  
  ##Mensage do tipo aviso.
  function aviso(mensagem)
    warndlg(mensagem);
  endfunction
  
  ##Seletor da lista de imagens no histórico
  function [sel, ok] = select_img_hist(nome)
    global hist;
    global hist_filt;
    global qt;
    
    t = qt;
    
    for x = 1:t;
      list_option{x} = strcat(num2str(x)," - ",hist_filt{x});
      disp(list_option{x});
    endfor
    [sel, ok] = listdlg ("Name",nome,"ListString", list_option,"SelectionMode","Single");  
  endfunction
  
  
  ##Mostra imagem
  function show_i(fig,a,b,c,img,titulo)
    figure(fig), subplot(a,b,c);imshow(img);
    title(titulo);
  endfunction
  
  
  ##Atualiza Histórico
  function atualiza_historico(a_t,a_hist,a_hist_filt)
    global qt;
    global hist;
    global hist_filt;
    
    qt = a_t;
    hist{qt} = a_hist;
    hist_filt{qt} = a_hist_filt;
  endfunction
  
  function conf = entry_value(titulo,a_prompt,a_defaults,a_rowscols)
     %% Cria Caixa de configuração
     prompt = a_prompt;
     defaults = a_defaults;
     rowscols = a_rowscols;
     conf = inputdlg (prompt,titulo, ...
                     rowscols, defaults);
  endfunction
  
  function [sel, ok] = get_opt_imfilter()
  list = {"symmetric","replicate","circular","same","full","corr","conv"};
  [sel, ok] = listdlg ("Name","Parametro imfilter","ListString",list,"SelectionMode","Single");      
  endfunction


