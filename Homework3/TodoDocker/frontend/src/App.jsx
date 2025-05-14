import { BrowserRouter, Routes, Route } from 'react-router-dom'
import Homepage from './pages/Homepage.jsx'
import Information from './pages/Information.jsx'

function App() {

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Homepage />} />
        <Route path="/info" element={<Information />} />
      </Routes>
    </BrowserRouter>
  )
}

export default App
