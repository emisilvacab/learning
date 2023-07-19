import './App.css';
import React, { Component } from 'react';

// GraphQL
import { graphql } from 'react-apollo';
import gql from 'graphql-tag';

class App extends Component {

  // Retrieves current data for menu items
  get menuItems() {
    const { data } = this.props;
    if (data && data.menuItems) {
      return data.menuItems;
    } else {
      return []
    }
  }

  renderMenuItem(menuItem) {
    return (
      <li key={menuItem.id}>{menuItem.name}</li>
    );
  }

  // Build the DOM
  render() {
    return (
      <ul>
        {this.menuItems.map(menuItem => this.renderMenuItem(menuItem))}
      </ul>
    )
  }
}

const query = gql`
  { menuItems { id name }}
`

export default graphql(query)(App);
