import React from 'react'

interface Props {
  text: string
  onClick: () => void
}

const SimpleButton = ({ text }: Props) => {
  const handleClick = () => {
    console.log('Hello World')
  }
  return <button onClick={handleClick}>{text}</button>
}

export default SimpleButton
