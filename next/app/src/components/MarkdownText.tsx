import { Box } from '@mui/material'
import { marked } from 'marked'
import 'zenn-content-css'

type MarkdownTextProps = {
  body: string
}

const MarkdownText = ({ body }: MarkdownTextProps) => {
  return (
    <Box
      className="znc"
      sx={{
        h1: { fontWeight: 'bold' },
        h2: { fontWeight: 'bold' },
        h3: { fontWeight: 'bold' },
      }}
    >
      <div dangerouslySetInnerHTML={{ __html: marked(body) }} />
    </Box>
  )
}

export default MarkdownText
