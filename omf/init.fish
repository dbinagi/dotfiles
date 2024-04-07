set -gx PROJECT_PATHS

if test -d /mnt/d/dev
    set -gx PROJECT_PATHS $PROJECT_PATHS /mnt/d/dev
end

if test -d /mnt/disk2/dev/repo
    set -gx PROJECT_PATHS $PROJECT_PATHS /mnt/disk2/dev/repo
end

if test -d /mnt/disk1/dev/repo
    set -gx PROJECT_PATHS $PROJECT_PATHS /mnt/disk1/dev/repo
end

# Add path for nvm
set -gx NVM_DIR ~/.nvm
