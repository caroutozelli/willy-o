# 🗺️ Willy-O

> App de caça ao tesouro desenvolvido em Flutter com Clean Architecture + MVVM, demonstrando boas práticas de código limpo, modularização por features e gerenciamento de estado com Riverpod.

---

## Funcionalidades

- Autenticação de usuário
- Mapa interativo de tesouros
- Detalhes de cada tesouro
- Navegação desacoplada via `go_router`
- Suporte a múltiplos ambientes (development, staging, production)
- Persistência local com Hive

---

## Arquitetura

O projeto segue **Clean Architecture** combinada com **MVVM**, organizado por features:

```
UI (View)
  └── ViewModel         ← estado e lógica de apresentação
        └── UseCase     ← regra de negócio
              └── Repository ← fonte única da verdade
                    └── Service ← API, GPS, banco local
```

| Camada | Responsabilidade |
|---|---|
| **View** | Desenhar a tela, chamar ViewModel |
| **ViewModel** | Estado e lógica de apresentação via Riverpod |
| **Repository** | Fonte única da verdade |
| **Service** | Comunicação externa (API, GPS, banco local) |

---

## Estrutura de Pastas

```
lib/
├── core/
│   ├── components/        # widgets reutilizáveis globais
│   ├── constants/         # cores, strings, dimensões
│   ├── extensions/        # extensões de tipos nativos
│   ├── theme/             # tema global do app
│   └── utils/             # helpers genéricos
│
├── features/
│   ├── auth/
│   │   ├── data/          # repository + service
│   │   ├── domain/        # models + use cases
│   │   └── presentation/  # view + viewmodel + components locais
│   │
│   ├── treasure_map/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── treasure_details/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── app.dart               # MaterialApp + roteamento
└── main.dart              # entry point por flavor
```

> Componentes usados em **1 feature** ficam em `features/nome_feature/presentation/components/`.
> Componentes usados em **2+ features** sobem para `core/components/`.

---

## Stack e Packages

### Gerenciamento de estado
```yaml
flutter_riverpod: ^2.x
riverpod_annotation: ^2.x
```

### Navegação
```yaml
go_router: ^14.x
```

### HTTP e API
```yaml
dio: ^5.x
```

### Banco local
```yaml
hive_flutter: ^1.x
```

### Geração de código e models
```yaml
freezed: ^3.x
freezed_annotation: ^3.x
json_serializable: ^6.x
build_runner: ^2.x
```

### Qualidade
```yaml
very_good_analysis: ^6.x
```

---

## Flavors (Ambientes)

| Flavor | Uso | API Base URL |
|---|---|---|
| `development` | desenvolvimento local | `https://dev.api.willy-o.com` |
| `staging` | testes e QA | `https://staging.api.willy-o.com` |
| `production` | app final | `https://api.willy-o.com` |

```bash
# desenvolvimento
flutter run --flavor development --target lib/main_dev.dart

# staging
flutter run --flavor staging --target lib/main_staging.dart

# produção
flutter run --flavor production --target lib/main_prod.dart
```

---

## Como rodar

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/willy_o.git
cd willy_o

# 2. Instale as dependências
flutter pub get

# 3. Gere os arquivos de código (freezed, json_serializable)
dart run build_runner build --delete-conflicting-outputs

# 4. Verifique a integridade
flutter analyze
flutter test

# 5. Rode o app
flutter run --flavor development --target lib/main_dev.dart
```

---

## Testes

```bash
# Rodar todos os testes
flutter test

# Rodar testes de uma feature específica
flutter test test/features/auth/
flutter test test/features/treasure_map/
```

- Todo **ViewModel** tem testes unitários
- Todo **Repository** tem testes com mock do Service
- Localização: `test/features/nome_feature/`
- Nomenclatura: `nome_do_arquivo_test.dart`

---

## Convenções

| Tipo | Padrão | Exemplo |
|---|---|---|
| Arquivos | `snake_case` | `treasure_card.dart` |
| Classes | `PascalCase` | `TreasureCard` |
| Variáveis/funções | `camelCase` | `fetchTreasures()` |
| Constantes | `camelCase` + prefixo `k` | `kPrimaryColor` |
| Providers | `camelCase` + sufixo | `treasureListProvider` |
| ViewModels | sufixo `ViewModel` | `TreasureViewModel` |
| Repositories | sufixo `Repository` | `TreasureRepository` |
| Services | sufixo `Service` | `TreasureService` |
| Models | sem sufixo | `Treasure`, `User` |

---

## Checklist antes de cada commit

- [ ] Nenhum widget com mais de 50 linhas
- [ ] Nenhuma função com mais de 20 linhas
- [ ] Nenhum código duplicado
- [ ] Nenhuma string/número solto (usar constants)
- [ ] Linter sem warnings (`flutter analyze`)
- [ ] Testes passando (`flutter test`)

---

## Licença

MIT © 2025 — Projeto de demonstração para estudos e avaliação técnica.
