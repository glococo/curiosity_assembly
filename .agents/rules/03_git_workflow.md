# Git & Contribution Guidelines

## 1. Commit Messages
Use Conventional Commits with clear component scoping:
- `feat(hal)`: New HAL peripheral module or feature
- `feat(driver)`: New external sensor/peripheral driver
- `fix(math)`: Bug fix in arithmetic or shift routines
- `docs(notes)`: Architectural notes or convention updates
- `test(examples)`: New test case or sample application

## 2. Clean Builds & Artifacts
- Never commit generated build artifacts (`*.elf`, `*.hex`, `*.o`, `*.bin`).
- Ensure `.gitignore` ignores all build outputs.
- Before committing, verify code builds cleanly for at least one target board using `./curiosity.sh`.

## 3. Modifying Drivers & Boards
- Keep core logic in `hal/` completely board-agnostic.
- Target board configurations in `boards/` must define hardware routing and MCU headers.
