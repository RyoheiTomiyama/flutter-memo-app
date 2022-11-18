# memo_app

A new Flutter project.

## クリーンアーキテクチャー風にしてみる

### 全体図

```
- /Domain: ビジネスロジック
-- Entity, IRepository, IUseCase, IPresenter　実装は入れない

- /Application: アプリケーションロジック
-- Interactor: IUseCaseの実装部分 IReposity, Ipresenterを受け取ってどういった処理を行うのか

- /Interface: 実装部分
-- Repository, Presenterの実装を行う
```

Presenterを使う場面のは手間が増えるだけなので、今の所使わなず、UseCaseInteractorから値を返す。

Controllerもなし。riverpodのmodelがControllerの役割を担う。