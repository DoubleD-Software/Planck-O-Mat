FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN npm install --global corepack@latest
RUN corepack enable
RUN corepack enable pnpm
COPY . /app
WORKDIR /app

FROM base AS prod-deps
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

FROM base AS build
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN mkdir -p /dist
RUN pnpm run build
CMD ["sh", "-c", "rm -rf /dist/* && cp -r /app/build/* /dist/ && chmod -R 777 /dist/"]