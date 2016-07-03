import React from 'react'
import classes from './Hello.scss'

export const Hello = (props) => {
  return (
    <div>
      <h2 className={classes.counterContainer}>Hello {props.routeParams.room}</h2>
    </div>
  )
}

Hello.propTypes = {
  // conductor: React.PropTypes.number.isRequired,
  // increment: React.PropTypes.func.isRequired
}

export default Hello
