const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotification = functions.firestore.document('Tasks/{documentId}')
    .onCreate(async (snapshot, context) => {
        const data = snapshot.data();
        const priority = data.priority;

        // Check if priority is "high"
        if (priority === 'high') {
            // Send FCM notification
            var message = {
                notification: {
                    title: 'High Priority Notification',
                    body: 'A document with high priority was added!',
                },

            };

            try {
                admin.messaging().sendToDevice('dAVn-IzqReSfl33DqmoTyR:APA91bFEtlmqDQ8gl4VcW6BGLt4m32rxEI3uBq75Wcvx_MF0VB9sK8wkavMXE5XVSxMMOxEGActv92T_90Bzk0_fDov64vJV66JZAZUmOTFzwI2fozwr6L1xG2UzO_xPSFYJMcqE_T5Z', message);

            } catch (error) {
                console.log(error);
            }
        }

        return null;
    });