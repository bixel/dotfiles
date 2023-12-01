#! /usr/bin/env python3
"""
Create symlinks to homebrewed python-installations that can be used alongside
pyenv.

After running this script, you can use e.g. homebrew's python@3.12 via
```
pyenv shell 3.12
```
- You can still install pyenv versions
- you can still create virtualenvironments based on the homebrew versions
"""

import subprocess
from pathlib import Path
from dataclasses import dataclass
import logging


@dataclass
class Binary:
    executable: str
    links: list[str]


BINARIES_TO_LINK = [
    Binary(executable="python{version}", links=["python3", "python"]),
    Binary(executable="pip{version}", links=["pip3", "pip"]),
    Binary(executable="idle{version}", links=["idle3", "idle"]),
    Binary(executable="pydoc{version}", links=["pydoc3", "pydoc"]),
    Binary(executable="wheel{version}", links=["wheel3", "wheel"]),
    Binary(
        executable="python{version}-config",
        links=["python3-config", "python-config"],
    ),
]
DIRS_TO_LINK = ["include", "lib", "share"]

installed_brew_packages = subprocess.getoutput("brew list").split()
brew_prefix = Path(subprocess.getoutput("brew --prefix")) / "opt"

installed_versions = [p for p in installed_brew_packages if "python@" in p]

logging.info(f"Will link following installed versions: {installed_versions}")

homedir = Path.home()
pyenv_dir = Path(subprocess.getoutput("pyenv root")) / "versions"
logging.info(f"Will add all necessary links to {pyenv_dir}")

for pyversion in installed_versions:
    logging.info(f"Check dir for {pyversion}")
    _, version = pyversion.split("@")
    (pyenv_dir / version).mkdir(exist_ok=True)
    for binary in BINARIES_TO_LINK:
        (pyenv_dir / version / "bin").mkdir(exist_ok=True)
        target = (
            brew_prefix / pyversion / "bin" / binary.executable.format(version=version)
        )
        source = pyenv_dir / version / "bin" / binary.executable.format(version=version)
        if source.is_file():
            if source.resolve() != target.resolve():
                logging.warning(
                    f"{source} is different from {target}, skipping {pyversion}"
                )
            continue

        source.symlink_to(target)
        for link in binary.links:
            source = pyenv_dir / version / "bin" / link
            target = brew_prefix / pyversion / "libexec/bin" / link
            if source.is_symlink():
                logging.warning(f"Link {target} -> {source} already exists. Skipping.")
                continue
            source.symlink_to(target)

    for dir_ in DIRS_TO_LINK:
        target = brew_prefix / pyversion / dir_
        source = pyenv_dir / version / dir_
        if source.is_dir():
            if source.resolve() != target.resolve():
                logging.warning(
                    f"{source} is a proper directory, skipping. "
                    f"Linking for {pyversion} might be broken now."
                )
            continue
        if not source.is_symlink():
            source.symlink_to(target, target_is_directory=True)

logging.info("Rehashing pyenv")
subprocess.call(["pyenv", "rehash"])
