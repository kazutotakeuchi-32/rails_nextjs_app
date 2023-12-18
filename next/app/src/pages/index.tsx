import { Box, Grid, Container, Pagination } from '@mui/material'
import camelcaseKeys from 'camelcase-keys'
import type { NextPage } from 'next'
import Link from 'next/link'
import { useRouter } from 'next/router'
import useSWR from 'swr'
import ArticleCard from '@/components/ArticleCard'
import Error from '@/components/Error'
import Loading from '@/components/Loading'
import { styles } from '@/styles'
import type { ArticleProps } from '@/types/article'
import { fetcher } from '@/utils'

const Index: NextPage = () => {
  const router = useRouter()
  const page = router.query.page || 1

  const url = `${process.env.NEXT_PUBLIC_API_BASE_URL}/articles?page=${page}`
  const { data, error } = useSWR(url, fetcher)
  if (error) return <Error />
  if (!data) return <Loading />

  const articles = camelcaseKeys(data.articles)
  const meta = camelcaseKeys(data.meta)

  const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
    router.push(`/?page=${value}`)
  }

  return (
    <Box css={styles.pageMinHeight} sx={{ backgroundColor: '#e6f2ff' }}>
      <Container maxWidth="md" sx={{ pt: 6 }}>
        <Grid container spacing={4}>
          {articles.map((article: ArticleProps, i: number) => (
            <Grid key={i} item xs={12} md={6}>
              <Link href={'/articles/' + article.id}>
                <ArticleCard
                  id={article.id}
                  title={article.title}
                  fromToday={article.fromToday}
                  userName={article.user.name}
                  createdAt={article.createdAt}
                />
              </Link>
            </Grid>
          ))}
        </Grid>
        <Box sx={{ display: 'flex', justifyContent: 'center', py: 6 }}>
          <Pagination
            count={meta.totalPages}
            page={meta.currentPage}
            onChange={handleChange}
          />
        </Box>
      </Container>
    </Box>
  )
}

export default Index
