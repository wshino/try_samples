
using System;
using System.IO;
using System.Linq;
using System.Reactive.Disposables;
using System.Reactive.Linq;

class FileSample
{
	static void Main(string[] args)
	{
		FromFile(args[0]).Subscribe(Console.WriteLine);

		Console.WriteLine("-----");

		FromFile(args[0]).Skip(1).Take(2).Select(x => "#" + x).Subscribe(Console.WriteLine);

	}

	private static IObservable<string> FromFile(string fileName)
	{
		return Observable.Create<string>(observer => {
			try
			{
				using(var reader = File.OpenText(fileName))
				{
					string s = null;

					while ((s = reader.ReadLine()) != null)
					{
						observer.OnNext(s);
					}

					observer.OnCompleted();
					Console.WriteLine("*** close");
				}
			}
			catch (Exception error) {
				observer.OnError(error);
			}
			return Disposable.Empty;
		});
	}
}