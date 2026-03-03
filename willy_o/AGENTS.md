# AGENTS.md - Willy-O Project

> Este arquivo define as regras, arquitetura e padrões do projeto Willy-O.
> O agente deve ler e seguir este documento em todas as sessões, sem exceção.

---

## Princípios Fundamentais

1. **Menos é mais** - menos linhas, menos arquivos, menos complexidade
2. **Reciclagem máxima** - componentes e lógica reutilizáveis sempre que possível
3. **Nomes claros** - nomes autoexplicativos, sem abreviações obscuras
4. **Uma responsabilidade** - cada classe, função e widget faz apenas uma coisa
5. **Nunca repita código** - se usou duas vezes, vira componente

---

## Arquitetura: Clean Architecture + MVVM

```
UI (View)
  └── ViewModel         ← estado e lógica de apresentação
        └── UseCase     ← regra de negócio (opcional para features simples)
              └── Repository ← fonte única da verdade
                    └── Service ← API, GPS, banco local, etc.
```

### Regras por camada

| Camada | Responsabilidade | Proibido |
|---|---|---|
| **View** | Desenhar a tela, chamar ViewModel | Lógica, chamadas de API, if/else complexo |
| **ViewModel** | Estado, lógica de apresentação | Chamadas diretas à API, UI code |
| **Repository** | Fonte única da verdade | Lógica de negócio, UI |
| **Service** | Comunicação externa (API, GPS, DB) | Lógica de negócio, estado |

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

### Regra de componentes

- Componentes usados em **1 feature** → `features/nome_feature/presentation/components/`
- Componentes usados em **2+ features** → `core/components/`

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

### Utilitários
```yaml
freezed: ^3.x
freezed_annotation: ^3.x
json_serializable: ^6.x
build_runner: ^2.x
```

### Dev / Qualidade
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

### Executar por flavor
```bash
flutter run --flavor development --target lib/main_dev.dart
flutter run --flavor staging    --target lib/main_staging.dart
flutter run --flavor production --target lib/main_prod.dart
```

---

## Convenções de Nomenclatura

| Tipo | Padrão | Exemplo |
|---|---|---|
| Arquivos | `snake_case` | `treasure_card.dart` |
| Classes | `PascalCase` | `TreasureCard` |
| Variáveis/funções | `camelCase` | `fetchTreasures()` |
| Constantes | `camelCase` com prefixo `k` | `kPrimaryColor` |
| Providers | `camelCase` + sufixo | `treasureListProvider` |
| ViewModels | sufixo `ViewModel` | `TreasureViewModel` |
| Repositories | sufixo `Repository` | `TreasureRepository` |
| Services | sufixo `Service` | `TreasureService` |
| Models | sem sufixo | `Treasure`, `User` |

---

## Regras de Código Limpo

### Funções
- Máximo **20 linhas** por função
- Um único objetivo por função
- Prefira `=>` para funções de uma linha

```dart
// certo
String get fullName => '$firstName $lastName';

// errado
String getFullName() {
  return firstName + ' ' + lastName;
}
```

### Widgets
- Máximo **50 linhas** por widget
- Extraia sub-widgets nomeados ao invés de aninhar
- Sem lógica condicional complexa no `build()`

```dart
// certo
Widget build(BuildContext context) => Column(
  children: [
    _Header(title: title),
    _Body(items: items),
  ],
);

// errado
Widget build(BuildContext context) {
  if (isLoading) { ... }
  else if (hasError) { ... }
  // 80 linhas depois...
}
```

### Models
- Sempre use `freezed` para models imutáveis
- Sempre implemente `copyWith`, `fromJson` e `toJson`

```dart
@freezed
class Treasure with _$Treasure {
  const factory Treasure({
    required String id,
    required String name,
    required LatLng location,
  }) = _Treasure;

  factory Treasure.fromJson(Map<String, dynamic> json) =>
      _$TreasureFromJson(json);
}
```

### Providers (Riverpod)
- Um provider por responsabilidade
- Use `AsyncNotifierProvider` para estados assíncronos
- Use `Provider` para valores derivados/computados

```dart
// certo
@riverpod
class TreasureList extends _$TreasureList {
  @override
  Future<List<Treasure>> build() =>
      ref.read(treasureRepositoryProvider).getAll();
}
```

---

## Proibições Absolutas

- Lógica de negócio dentro de widgets
- Chamadas diretas à API fora de Services
- `setState` (usar Riverpod)
- Strings e números mágicos soltos no código
- Comentários óbvios (`// incrementa contador`)
- Imports relativos longos (usar barrel exports `index.dart`)
- Código comentado no repositório
- Classes com mais de 150 linhas sem refatoração

---

## Fluxo de Desenvolvimento por Feature

Para cada nova feature, seguir essa ordem:

1. **Model** - define a estrutura de dados com `freezed`
2. **Service** - comunicação com API ou banco local
3. **Repository** - abstrai a fonte de dados
4. **ViewModel** - estado e lógica de apresentação via Riverpod
5. **View** - apenas monta a tela usando o ViewModel
6. **Componentes** - extrai widgets reutilizáveis
7. **Testes** - unit test do ViewModel e Repository

---

## Testes

- Todo **ViewModel** deve ter testes unitários
- Todo **Repository** deve ter testes com mock do Service
- Nomenclatura: `nome_do_arquivo_test.dart`
- Localização: `test/features/nome_feature/`

---

## Checklist antes de cada commit

- [ ] Nenhum widget com mais de 50 linhas
- [ ] Nenhuma função com mais de 20 linhas
- [ ] Nenhum código duplicado
- [ ] Nenhuma string/número solto (usar constants)
- [ ] Linter sem warnings (`flutter analyze`)
- [ ] Testes passando (`flutter test`)

---

## Setup inicial do projeto

```bash
# 1. Criar projeto
flutter create --org com.willyo willy_o

# 2. Entrar na pasta
cd willy_o

# 3. Adicionar packages ao pubspec.yaml

# 4. Gerar código
dart run build_runner build --delete-conflicting-outputs

# 5. Verificar integridade
flutter analyze
flutter test
```
