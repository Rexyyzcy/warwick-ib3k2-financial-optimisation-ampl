# AMPL quickstart notes

These are a short, edited companion to my personal notes from IB3K2. The original notes included screenshots from course resources; those screenshots are not reproduced here.

## The three files

- `.mod` defines the mathematical model: sets, parameters, variables, an objective and constraints.
- `.dat` supplies parameter values for a particular instance.
- `.run` contains commands to load the model and data, choose a solver, solve and display results.

AMPL statements end with a semicolon. Multiplication uses `*`.

```ampl
reset;
model example.mod;
data example.dat;
option solver gurobi;
solve;
display x;
```

From an AMPL prompt, `include example.run;` executes the script. A model with all its required values defined inside the `.mod` file may not need a `.dat` file. The historical scripts in this archive use solver names and syntax as recorded at the time; they have not been edited or re-tested.

## Useful commands

| Command | Purpose |
| --- | --- |
| `reset;` | Clear the current model and data. |
| `model example.mod;` | Load model declarations. |
| `data example.dat;` | Load data values. |
| `option solver gurobi;` | Select a solver when available. |
| `solve;` | Solve the active optimization problem. |
| `display x;` | Show a variable's current values. |
| `display constraint_name.dual;` | Show dual values of a constraint. |
| `display constraint_name.slack;` | Show slack values of a constraint. |
| `display constraint_name.body;` | Show values of the constraint body. |

In AMPL, displaying a constraint by name alone reports its dual value. Use an explicit suffix to request slack or body values. See the [AMPL suffix reference](https://dev.ampl.com/ampl/reference/suffixes.html).
