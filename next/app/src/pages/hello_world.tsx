import { NextPage } from 'next'
import SimpleButton from '@/components/SimpleButton'

const HelloWorld: NextPage = () => {
  return (
    <div>
      Hello World
      <SimpleButton text={'test'} onClick={'name'} />
    </div>
  )
}

export default HelloWorld
