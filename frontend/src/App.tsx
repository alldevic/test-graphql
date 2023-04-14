import { CreateTodo, TodoList } from './components'
import './App.css'

function App() {
  return (
    <div className="App">
      <h1>Vite + React</h1>

      <CreateTodo />

      <TodoList />
    </div>
  )
}

export default App
