export enum Status {
  UNSAVED = '未保存',
  SAVED = '保存済み',
  PUBLISHED = '公開中',
}

export type ArticleProps = {
  id: number
  title: string
  createdAt: string
  fromToday: string
  body: string
  user: {
    name: string
  }
}

export type CurrentArticleProps = {
  id: number
  title: string
  body: string
  createdAt: string
  status: Status
}

export type EditArticleProps = {
  title: string
  body: string
  status: Status
}

export type ArticleFormData = {
  title: string
  body: string
}
