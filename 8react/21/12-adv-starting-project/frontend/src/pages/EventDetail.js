import { useRouteLoaderData, Link, json, redirect, defer, Await } from "react-router-dom";
import EventItem from '../components/EventItem';
import EventsList from "../components/EventsList";
import { Suspense } from "react";

function EventDetailPage() {
  const { event, events } = useRouteLoaderData('event-detail');

  return (
    <>
      <Suspense fallback={<p style={{textAlign: 'center'}}>Loading...</p>}>
        <Await resolve={event}>
          {loadedEvent => <EventItem event={loadedEvent} />}
        </Await>
      </Suspense>
      <Suspense fallback={<p style={{textAlign: 'center'}}>Loading...</p>}>
        <Await resolve={events}>
          {loadedEvents => <EventsList events={loadedEvents} />}
        </Await>
      </Suspense>
      <p><Link to=".." relative="path">Back</Link></p>
    </>
  );
};

export default EventDetailPage;

async function loadEvent(id) {
  const response = await fetch('http://localhost:8080/events/' + id);

  if (!response.ok) {
    throw json(
      { message: 'Could not fetch details for  selected event.' },
      { status: 500 }
    );
  } else {
    const resData = await response.json();
    return resData.event;
  }
}

async function loadEvents() {
  const response = await fetch('http://localhost:8080/events');
  if (!response.ok) {
    return json(
      { message: 'Could not fetch events.' },
      { status: 500 }
    );
  } else {
    const resData = await response.json();
    return resData.events;
  }
}

export async function loader({request, params}) {
  const id = params.eventId;

  return defer({
    event: await loadEvent(id),
    events: loadEvents()
  })
};

export async function action({params, request}) {
  const id = params.eventId
  const response = await fetch('http://localhost:8080/events/' + id, {
    method: request.method
  });

  if (!response.ok) {
    throw json(
      {message: 'Could not delete event.'},
      {status: 500}
    );
  }
  return redirect('/events');
}