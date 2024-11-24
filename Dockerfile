# syntax=docker/dockerfile:1
# Definindo a versão do Ruby, para que seja a mesma utilizada no projeto
ARG RUBY_VERSION=3.3.6
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Instalar pacotes básicos para o ambiente de desenvolvimento
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libpq-dev libvips sqlite3 nodejs yarn git build-essential && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Configuração do ambiente de desenvolvimento
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="production"

# Instalar pacotes necessários para compilar gems
FROM base AS build

# Instalar gems do projeto
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copiar o código da aplicação
COPY . .

# Ajustar permissões de arquivos binários
# Ajustar permissões de arquivos binários e corrigir a formatação dos scripts
RUN chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/\r//' bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/*

# Finalizando a imagem de desenvolvimento
FROM base

# Copiar os artefatos construídos (gems e código da aplicação)
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Definir a imagem para rodar como usuário não-root
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

USER 1000:1000

# Entrypoint para o Rails, ajustado para o ambiente de desenvolvimento
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expor a porta 3000 (padrão para desenvolvimento)
EXPOSE 3000

# Comando para rodar o servidor Rails no modo de desenvolvimento
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
