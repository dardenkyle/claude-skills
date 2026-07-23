# Global Coding Standards

General standards for all projects. Course-specific requirements (file
comment headers, submission rules) live in `~/Code/data-structures/CLAUDE.md`
and apply only to school repos.

This file is version-controlled in the `claude-skills` repo and symlinked to
`~/.claude/CLAUDE.md` by its `setup.sh`. Edit it there, not in place.

## Career Context

Canonical career / job-search context lives in the private `claude-context`
repo and is imported below. Consult it whenever career, job-search, resume,
positioning, or portfolio-strategy context is relevant. Edit it in the repo,
not here.

@~/Code/claude-context/CAREER.md

## Agent Behavior Rules

Cross-project agent rules (communication, git/commits, PRs and review,
workflow, tooling) live in the claude-context repo and are imported below.
Edit them there, not here.

@~/Code/claude-context/PREFERENCES.md

## Project Status

@~/Code/claude-context/PROJECTS.md

---

## Function / Method Comment Block

Goes **below** the function header, **above** the function body. Never above the header.

```cpp
ReturnType functionName(params) {
/* *************************************************
* [Description of what the function does]
*
* @param [name] : [description]  (use "na" if none)
* @return [type] : [description] (use "void" if none)
* @exception : [description]     (use "none" if none)
* @note : [notes]                (use "na" if none)
* ************************************************* */
    // body
}
```

All four tags (@param, @return, @exception, @note) are **always required**, even when inapplicable — write `na` or `none`. Do not add or remove tags. Do not reformat the star pattern.

## Class Header File Structure (C++)

```cpp
class ClassName {
public:
    /**********************
    * Constructors/Destructor
    ***********************/
    ClassName(type);
    ~ClassName();

    /**********************
    * Getters/Accessors
    ***********************/

    /**********************
    * Setters/Mutators
    ***********************/

    /**********************
    * Printing Methods
    ***********************/

private:

    /**********************
    * Methods
    ***********************/

    /**********************
    * Attributes
    ***********************/
    type attribute;
};
```

No method comment blocks in the `.h` file — declarations only. Method comment blocks go in `.cpp`.

## C-Style Formatting

- **Indentation:** 4 spaces per level. No tabs.
- **Line length:** 80 characters max. Break at logical points (after operators or commas); indent continuation lines to align with statement start.
- **Spacing:** Spaces around operators and after commas. No spaces directly inside parentheses. `if (x > 0)` not `if(x>0)`.
- **Braces:** Always use braces for code blocks, even single-statement blocks.
- **Statements:** One statement per line, always.
- **Brace style:** K&R or Allman — pick one and use it consistently.

## Naming Conventions

- **Procedural code:** `underscore_naming`
- **OOP (methods, variables):** `camelCase`
- **Constants:** `ALL_CAPS`
- **Class / ADT names:** Capitalized first letter (`Stack`, `Node`)
- **Files:** Lowercase, no spaces (`stack.h`, `functions.cpp`)
- **Counter variables:** `i`, `j`, `k` are acceptable exceptions

## Namespaces

- Never `using namespace std;` anywhere.
- Qualify each use: `std::string`, `std::cout`, etc.

## Functions and Methods

- One and only one `return` statement per function/method.
- The `return` must be at the **end** of the function body — never inside an `if`, loop, or any nested block.
- Functions must do **one and only one** logical task.
- Functions must be **under 20 lines** (driver `main()` is exempt).
- No 1–2 line functions, except getters/setters.
- Functions must **not print** unless printing is their sole purpose.
- No `exit()`, `abort()`, or `quit()` anywhere except possibly the very end of `main()`.

## Loops

- No `break` or `continue`.
- No function calls in loop headers.
- No variable declarations inside loops (C/C++).
- Avoid `if` statements inside loops when possible.
- Use `for` when iteration count is known; `while` when unknown.
- No purposeful infinite loops.

## Variables and Scope

- All variables must be local.
- No global variables. Global **constants** are acceptable.
- Do not use literals directly in code without good reason. Local-use literals go at the top of the scope; multi-scope literals go in a global constant.

## OOP Rules

- All class attributes must be **private** (or protected). Never public.
- Every attribute read/written from outside the class needs a getter/setter.
- Never return the memory address of an attribute.
- Setters must include error checking and correction.
- Constructors must leave the object in a viable, ready-to-use state.
- Constructors should almost never print.
- Each class in its own file, named for the class.

## File Organization (C++)

- `.cpp` files include **only their own header**. No other `#include` directives in `.cpp` files.
- All other `#include` directives belong in the appropriate `.h` file.
- `main()` is the only function in the driver file.
- No other functions in `main.cpp`.

## Commit Standards

- Commit **smart, small, and often** (every 15–45 minutes of work).
- Messages must explain **what**, **how**, and **why** — enough that another programmer can reconstruct your reasoning.
- Never write: "done," "fixed bug," "added css," "implemented methods."
- Do not commit: executables, IDE directories, OS files, sensitive data.
- Keep a proper `.gitignore` and `README.md` in every repository.
