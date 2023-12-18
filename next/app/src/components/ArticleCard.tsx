import { Box, Card, CardContent, Typography } from '@mui/material'

interface ArticleCardProps {
  id: number
  title: string
  createdAt: string
  fromToday: string
  userName: string
}

const omit = (str: string) => (num: number) => (end: string) => {
  if (str.length <= num) return str
  return str.slice(0, num) + end
}

const ArticleCard = (props: ArticleCardProps) => {
  return (
    <Card>
      <CardContent>
        <Typography
          component="h3"
          sx={{
            mb: 2,
            minHeight: 48,
            fontSize: 16,
            fontWeight: 'bold',
            lineHeight: 1.5,
          }}
        >
          {omit(props.title)(45)('...')}
        </Typography>
        <Box sx={{ display: 'flex', justifyContent: 'space-between' }}>
          <Typography sx={{ fontSize: 12 }}>{props.userName}</Typography>
          <Typography sx={{ fontSize: 12 }}>{props.fromToday}</Typography>
        </Box>
      </CardContent>
    </Card>
  )
}

export default ArticleCard
