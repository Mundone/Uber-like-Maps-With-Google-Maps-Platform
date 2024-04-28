part of 'ride_booking_screen.dart';

class _RideBookingChoosePickUp extends StatefulWidget {
  const _RideBookingChoosePickUp();

  @override
  State<_RideBookingChoosePickUp> createState() =>
      _RideBookingChoosePickUpState();
}

class _RideBookingChoosePickUpState extends State<_RideBookingChoosePickUp> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<RideBookingBloc, RideBookingState>(
      builder: (context, state) {
        controller.text =
            '${state.pickUpAddress?.city ?? ''} ${state.pickUpAddress?.street ?? ''}';
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8.0),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Авхуулах газраа сонгоно уу.',
                  style: textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Хатгуурыг хөдөлгөхийн тулд газрын зургийг чирнэ үү.',
                  style: textTheme.bodyLarge,
                ),
                const Divider(height: 32.0),
                TextFormField(
                  readOnly: true,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Хайх',
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(12.0),
                      color: colorScheme.primary,
                      child: Icon(
                        Icons.square,
                        size: 10,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        readOnly: true,
                        controller: pickUpAddressController,
                        decoration: const InputDecoration(
                          isDense: true,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      TextFormField(
                        controller: dropOffAddressController,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Хаашаа?',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (String value) {
                          // TODO: DEBOUNCE

                          context.read<RideBookingBloc>().add(
                                SearchDropOffAddressEvent(query: value),
                              );
                        },
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48.0),
                  ),
                  onPressed: () {
                    context
                        .read<RideBookingBloc>()
                        .add(ConfirmPickUpAddressEvent());
                  },
                  child: Text('Авхуулах газраа баталгаажуулах'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
