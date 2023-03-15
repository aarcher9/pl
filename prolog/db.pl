%%%% -*- Mode: Prolog -*-

% Non interactive execution:
% $ swipl ... -g 'nl' -t halt  

% Load file (-l will preserve colors):
% $ swipl -l db.pl

% $ swipl often prompts user to type something (e.g. when findall( , , ) is not used prolog prompt will ask user what to do next); when streaming with '<' from bash this will throw an error. Remember to implement a proper way to handle user interaction.
% Run queries from file (does not print welcome message):
% $ swipl -s db.pl -g 'true' -g 'nl' < q.pl

cat(tom).
cat(boot).
cat(jerry).
mouse(jerry).
chimera(X) :- cat(X), mouse(X).
