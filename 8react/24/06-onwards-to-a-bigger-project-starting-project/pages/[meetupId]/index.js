import { MongoClient, ObjectId } from "mongodb";
import MeetupDetail from "../../components/meetups/MeetupDetail";

function MeetupDetails() {
  return (
    <MeetupDetail
      title={props.meetupData.title}
      image={props.meetupData.image}
      address={props.meetupData.address}
      description={props.meetupData.description}
    />
  );
}

export async function getStaticPaths() {
  const client = await MongoClient.connect('mongodb+srv://emiliano:2Zk1ycrFXoxEmCJp@cluster0.yfrhm1a.mongodb.net/meetups?retryWrites=true&w=majority')
  const db = client.db();
  const meetupsCollection = db.collection('meetups');

  const meetups = await meetupsCollection.find({}, {_id: 1}).toArray();

  client.close();

  return {
    fallback: false,
    paths: meetups.map((meetup) => ({
      params: { meetupId: meetup._id.toString()}
    })),
  }
}

export async function getStaticProps(context) {
  const meetupId = context.params.meetupId;

  const client = await MongoClient.connect('mongodb+srv://emiliano:2Zk1ycrFXoxEmCJp@cluster0.yfrhm1a.mongodb.net/meetups?retryWrites=true&w=majority')

  const db = client.db();

  const meetupsCollection = db.collection('meetups');

  const selectedMeetup = meetupsCollection.findOne({
    _id: ObjectId(meetupId),
  });

  // const meetups = await meetupsCollection.find({}, {_id: 1}).toArray();

  client.close();

  console.log(meetupId)

  return {
    props: {
      meetupData: {
        id: selectedMeetup.id.toString(),
        title: selectedMeetup.title,
        address: selectedMeetup.address,
        image: selectedMeetup.image,
        description: selectedMeetup.description
      }
    }
  }
}

export default MeetupDetails;