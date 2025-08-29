/// ===============================
/// To-Do-Liste (Konsolenprogramm)
/// ===============================
///
/// Aufgabe:
/// Schreibe ein Programm, das eine einfache To-Do-Liste verwaltet.
/// Der Benutzer kann:
///   - Aufgaben hinzufügen        (add <beschreibung>)
///   - Alle Aufgaben anzeigen     (list)
///   - Aufgaben als erledigt markieren (done <nummer>)
///   - Das Programm beenden       (exit)
///
/// Regeln:
/// - Jede Aufgabe bekommt eine Nummer.
/// - Erledigte Aufgaben werden mit [x] markiert, unerledigte mit [ ].
/// - Alle Befehle erfolgen über die Konsole.
/// - Es sollen Funktionen für jeden Command verwendet werden (bspw. void add())
///
/// Beispielablauf:
/// > add Hausaufgaben machen
/// Aufgabe hinzugefügt: Hausaufgaben machen
/// > add Müll rausbringen
/// Aufgabe hinzugefügt: Müll rausbringen
/// > list
/// [ ] 1. Hausaufgaben machen
/// [ ] 2. Müll rausbringen
/// > done 1
/// Abgehakt: 1. Hausaufgaben machen
/// > list
/// [x] 1. Hausaufgaben machen
/// [ ] 2. Müll rausbringen
/// > exit
/// Tschüss!

import 'dart:io';


void main() 
{

  Map<int, Map<String, bool>> tasks = {};
  int taskCounter = 1;

  stdout.writeln('');
  stdout.writeln('');
  stdout.writeln('\x1B[34m##################################################\x1B[0m');
  stdout.writeln('\x1B[34m###### Willkommen beim To-Do-Listen Programm! ####\x1B[0m');
  stdout.writeln('\x1B[34m##################################################\x1B[0m');
  stdout.writeln('');  
  
  while (true) 
  {
    stdout.writeln('--------------------------------------------------');
    stdout.writeln('------ mögliche Befehle:');
    stdout.writeln('------ add  | a <beschreibung>');
    stdout.writeln('------ list | l');
    stdout.writeln('------ done | d <nummer>');
    stdout.writeln('------ exit | x');
    stdout.writeln('--------------------------------------------------');
    stdout.writeln('');  
    stdout.write ('\x1B[34mGib hier deinen Befehl ein >>> \x1B[0m');

    String? input = readInput();
    if (input == null || trim(input).length == 0) 
    {
      continue;
    }  

    var parts = splitCommand(input);
    String command = parts[0];
    String argument = parts.length > 1 ? parts[1] : '';
    argument = trim(argument);

    switch (command) 
    {
      case 'add':
      case 'a':
        taskCounter = add(command, argument, taskCounter, tasks);
        list(tasks);
        break;
      case 'list':
      case 'l':
        list(tasks);
        break;
      case 'done':
      case 'd':
        done(command, argument, tasks);
        list(tasks);
        break;
      case 'exit':
      case 'x':
        stdout.writeln('');
        stdout.writeln('\x1B[34m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\x1B[0m');
        stdout.writeln('\x1B[34m!!!!!!!!!!!!!!!!!!! Tschüss !!!!!!!!!!!!!!!!!!!!!\x1B[0m');
        stdout.writeln('\x1B[34m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\x1B[0m');
        return;
      default:
        stdout.writeln('');
        stdout.writeln('\x1B[31mFEHLER: Unbekannter Befehl: $command\x1B[0m');
        stdout.writeln('');
    }
  }
}

/**
 * add a new task
 */
int add(String command, String task, int taskCounter, Map<int, Map<String, bool>> tasks) {
  if (task.length > 0) 
  {
    tasks[taskCounter] = {task: false};
    stdout.writeln('');
    stdout.writeln('\x1B[32mINFO: Aufgabe "${task}" hinzugefügt als unerledigte Aufgabe $taskCounter\x1B[0m');
     stdout.writeln('');
    taskCounter++;
  } 
  else 
  {
      stdout.writeln('');
      stdout.writeln('\x1B[31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\x1B[0m');
      stdout.writeln('\x1B[31mFEHLER: Bitte bei add auch eine Aufgabenbeschreibung angeben.\x1B[0m');
      stdout.writeln('\x1B[31m!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\x1B[0m');
      stdout.writeln('');
  }
  return taskCounter;
}

/**
 * list all tasks
 */
void list(Map<int, Map<String, bool>> tasks) {
  if (tasks.isEmpty) 
  {
      stdout.writeln('');
      stdout.writeln('\x1B[32mINFO: Keine Aufgaben vorhanden.\x1B[0m');
      stdout.writeln('');
    return;
  }

  stdout.writeln('');
  stdout.writeln('\x1B[32m************ Aktuelle Aufgaben: ********************\x1B[0m');
  tasks.forEach((jobNum, jobMap) 
  {
      stdout.writeln('\x1B[32m${jobMap.values.first ? '[x]' : '[ ]'} ${jobNum}. ${jobMap.keys.first}\x1B[0m');
  });
  stdout.writeln('');
}

/**
 * mark a task as done
 */
void done(String command, String task, Map<int, Map<String, bool>> tasks) 
{
  if (task.length > 0) 
  {
    int number = int.tryParse(task) ?? -1;
    
    if (tasks.containsKey(number)) {
      String taskName = tasks[number]!.keys.first;
      stdout.writeln('');
      stdout.writeln('\x1B[32mINFO: Aufgabe $number. "${taskName}" abgehakt.\x1B[0m');
      stdout.writeln('');
      tasks[number] = {taskName: true};
      
    } 
    else 
    {
        stdout.writeln('');
        stdout.writeln('\x1B[33mWARNUNG: Aufgabe ${number > 0 ? number : ''} nicht gefunden.\x1B[0m');
        stdout.writeln('');
    }
  }
  else 
  {
      stdout.writeln('');
      stdout.writeln('\x1B[31mFEHLER: Bitte bei done auch eine Aufgabennummer angeben.\x1B[0m');
      stdout.writeln('');
  }
}


/**
 * trim string
 */
String trim(String input) 
{
  int start = 0;
  int end = input.length - 1;

  // Find first non-space from the left
  while (start <= end && input[start] == ' ') 
  {
    start++;
  }

  // Find first non-space from the right
  while (end >= start && input[end] == ' ') 
  {
    end--;
  }

  // Build result with a for-loop
  String result = '';
  for (int i = start; i <= end; i++) 
  {
    result += input[i];
  }
  return result;
}


/**
 * split input command into parts command and argument
 */

List<String> splitCommand(String input) 
{
  List<String> parts = [];
  String command = '';
  String argument = '';
  bool commandCompleted = false;

  for (int i = 0; i < input.length; i++) {
    String char = input[i];

    if (!commandCompleted) 
    {
      if (char == ' ') 
      {
        if (command.length > 0) 
        {
          parts.add(command);
          command = '';
          commandCompleted = true;
        }
      } 
      else 
      {
        command += char;
      }
    } 
    else
    {
      argument += char;
    }
  }

  if (command.length > 0) 
  {
    parts.add(trim(command));
  }

  if (argument.length > 0) 
  {
    parts.add(trim(argument));
  }

  return parts;
}


/**
 * read input from console
 */
String? readInput() 
{
  String? input = stdin.readLineSync();
  return input;
}



