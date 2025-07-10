FROM ubuntu:latest

# --- Create a non-root user ---
ARG USER_ID=1001
ARG GROUP_ID=1001
ARG USERNAME=tdmanv

RUN groupadd --gid $GROUP_ID $USERNAME && \
    useradd --uid $USER_ID --gid $GROUP_ID -m $USERNAME


# Set HOME environment variable for the non-root user
ENV HOME=/home/$USERNAME
WORKDIR $HOME

# Update package lists
RUN apt-get update && apt-get upgrade -y

# Install essential tools
RUN apt-get install -y git curl stow zsh golang-go ripgrep wget

# Clean up apt cache to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Clone dotfiles repository (assuming public repo or SSH key setup later - IMPORTANT!)
RUN git clone https://github.com/tdmanv/dotfiles.git $HOME/dotfiles

# Install Oh My Zsh (replace with actual install commands from ohmyz.sh)
# Example (you might need to adapt based on ohmyz.sh instructions):
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Install Oh My Posh (replace with actual install commands from ohmyposh.dev)
# Example (you might need to adapt based on ohmyposh.dev instructions - often involves downloading a binary):
RUN wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
RUN chmod +x /usr/local/bin/oh-my-posh

# Create zsh config link using stow
RUN rm -rf $HOME/.zshrc
RUN stow --dir "$HOME/dotfiles/stow" --target "$HOME" -v 5 zsh

# --- Set default shell to zsh ---
RUN chsh -s /usr/bin/zsh $USERNAME


# --- Node.js and npm ---
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
# Make nvm available in the current and subsequent RUN commands
RUN export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
RUN export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install --lts
RUN export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use --lts && npm install -g npm@10.1.0

# --- Bash Language Server ---
RUN export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use --lts && npm i -g bash-language-server

ARG NEOVIM_VERSION="v0.10.4"
RUN wget -q "https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux-x86_64.appimage" -O /tmp/nvim.appimage && \
    chmod +x /tmp/nvim.appimage && \
    /tmp/nvim.appimage --appimage-extract && \
    chmod +x /tmp/nvim.appimage && \
    ln -s /squashfs-root/usr/bin/nvim /usr/local/bin/

# --- Nvim Configuration ---
RUN mkdir -p $HOME/.config/nvim
# Create nvim config link using stow
RUN stow --dir "$HOME/dotfiles/stow" --target "$HOME/.config/nvim/" -v 5 nvim

USER $USERNAME


# Install neovim packages with Lazy
#RUN nvim --headless -c "autocmd User LazyReady call lazy#sync()" -c "quitall"

# Switch to the non-root user for subsequent commands

# Default command when the container starts (optional - you can override when running)
CMD ["zsh"]
