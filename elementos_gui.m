
%Cria tela
p = uipanel("title", "FILTROS", "position", [0 0 1 1]);

%Caixa de ajuda
helpdlg ("Algum texto útil para o usuário.");
helpdlg ("Algum texto útil \ ncom duas linhas.");
helpdlg ({"Algum texto útil", "com duas linhas."});
helpdlg ("Algum texto útil para o usuário.", "Legenda extravagante");
   
%Erros
errordlg ("Ocorreu algum erro extravagante.");
errordlg ("Algum erro extravagante \ ncom duas linhas.");
errordlg ({"Algum erro extravagante", "com duas linhas."});
errordlg ("Ocorreu um erro extravagante.", "Legenda extravagante");

%Caixa de texto em caixa de dialogo
prompt = {"Largura", "Altura", "Profundidade"};
padroes = {"1,10", "2,20", "3,30"};
rowcols = [1,10; 2,20; 3,30];
dims = inputdlg (prompt, "Insira as dimensões da caixa", rowcols, padroes);

%Lista
my_options = {"An item", "another", "yet another"};
[sel, ok] = listdlg ("ListString", my_options,
                     "SelectionMode", "Multiple");
                     
 disp(sel);    


%Caixa de dialogo
msgbox ("Alguma mensagem para o usuário.");
msgbox ("Alguma mensagem \ ncom duas linhas.");
msgbox ({"Alguma mensagem", "com duas linhas."});
msgbox ("Alguma mensagem para o usuário.", "Legenda extravagante");

## Uma caixa de diálogo de mensagem com ícone de erro
msgbox ("Alguma mensagem para o usuário.", "Legenda extravagante", "erro");
    

%Caixa de pergunta
btn = questdlg ("Fechar Octave?","Algum título extravagante","op1", "op2","op3", "op1");

%Aviso
warndlg ("Algum texto de aviso para o usuário.");
warndlg ("Algum texto de aviso \ ncom duas linhas.");
warndlg ({"Algum texto de aviso", "com duas linhas."});
warndlg ("Algum texto de aviso para o usuário.", "Legenda extravagante");

%Caixa de dialogo personalizada
h = dialog ("name", "Dialog Example","position", [10 10 160 30]);

## create a button (default style)
b = uicontrol (h, "string", "Aplicar",
                  "position", [10 10 160 30],
                  "callback", "delete (gcf)");

## wait for dialog to resume or close
uiwait (h);


%Painel
## create figure and panel on it
f = figure;
p = uipanel ("title", "Panel Title", "position", [.25 .25 .5 .5]);

## add two buttons to the panel
b1 = uicontrol ("parent", p, "string", "A Button", ...
                "position", [18 10 150 36]);
b2 = uicontrol ("parent", p, "string", "Another Button", ...
                "position",[18 60 150 36]);
                
%%Botoes em grupo
## Create figure and panel on it
f = figure;
## Create a button group
gp = uibuttongroup (f, "Position", [ 0 0.5 1 1])
## Create a buttons in the group
b1 = uicontrol (gp, "style", "radiobutton", ...
                "string", "Choice 1", ...
                "Position", [ 10 150 100 50 ]);
b2 = uicontrol (gp, "style", "radiobutton", ...
                "string", "Choice 2", ...
                "Position", [ 10 50 100 30 ]);
## Create a button not in the group
b3 = uicontrol (f, "style", "radiobutton", ...
                "string", "Not in the group", ...
                "Position", [ 10 50 100 50 ]);
                
%CheckBox
f = figure;
b1 = uicontrol (f, "style", "checkbox", ...
                "string", "Not in the group", ...
                "Position", [ 10 50 100 50 ]);
                
%CheckBox
f = figure;
b1 = uicontrol (f, "style", "edit", ...
                "string", "Not in the group", ...
                "Position", [ 10 50 100 50 ]);
   
%List box   
f = figure;
b1 = uicontrol (f, "style", "listbox",
                "string", "Not in the group", ...
                "Position", [ 10 50 100 50 ]);
                
%List box   
f = figure;
b1 = uicontrol (f, "style", "popupmenu",
                "string", "Not in the group", ...
                "Position", [ 10 50 100 50 ],"list");

   f = figure;             
h = uicontrol (f,'style', 'popupmenu', 'string', 'A|B', 'value', 1)
% Is the object created? If so what does the following return?
disp(get (h, 'value'));

h = uicontrol ('style', 'popupmenu', 'string', 'A|B', 'value', 5)
% Is the object created? If so what does the following return?
get (h, 'value')

h = uicontrol ('style', 'popupmenu', 'string', 'A|B')
get (h, 'value')
set (h, 'value', 5)
get (h, 'value')
                
%List box   
f = figure;
b3 = uicontrol ("style", "slider", ...
                "string", "Not in the group", ...
                "Position", [ 10 10 500 20 ],"Min",0,"Max",100);

                
                
                
                
my_options = {"An item", "another", "yet another"};
[sel, ok] = listdlg ("ListString", my_options,
                     "SelectionMode", "Multiple");
        
my_options = uicontrol ("style", "slider",
                            "string", "slider",
                             "Position", [ 10 10 500 20 ]);        
                     
prompt = {"Width", "Height", "Depth"};
defaults = {"1.10", "2.20", "3.30"};
rowscols = [1,10; 2,20; 3,30];
dims = inputdlg (prompt, "Enter Box Dimensions", ...
                 rowscols, defaults);
t = 3;
div = t*t;
h;

for l = 1:t;
  g{l} = -1;
  if(i = 3/2 +1)
endfor

