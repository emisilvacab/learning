import { Outlet } from 'react-router-dom';
import EventsNavigation from '../components/EventsNavigation'

function EventRoot() {
  return (
    <>
      <EventsNavigation />
      <main>
        <Outlet />
      </main>
    </>
  )
};

export default EventRoot;